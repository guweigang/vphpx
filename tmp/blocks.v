import rt

fn remove_block_asset_path_prefix(var_asset_handle_or_path rt.PhpVal) rt.PhpVal {
	mut var_path_prefix := 'file:'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_asset_handle_or_path.dup(), rt.new_string(var_path_prefix).dup()]))))) {
		return var_asset_handle_or_path.dup()
	}
	mut var_path := rt.call_function('substr', [var_asset_handle_or_path.dup(), rt.new_int(var_path_prefix.len)])
	if rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), rt.new_string('./')])) {
		var_path = rt.call_function('substr', [var_path.dup(), rt.new_int(2)])
	}
	return var_path.dup()
}

fn generate_block_asset_handle(var_block_name rt.PhpVal, var_field_name rt.PhpVal, index i64) rt.PhpVal {
	if rt.is_true(rt.call_function('str_starts_with', [var_block_name.dup(), rt.new_string('core/')])) {
		mut var_asset_handle := rt.call_function('str_replace', [rt.new_string('core/'), rt.new_string('wp-block-'), var_block_name.dup()])
		if rt.is_true(rt.call_function('str_starts_with', [var_field_name.dup(), rt.new_string('editor')])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_field_name.dup(), rt.new_string('view')])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(rt.call_function('str_ends_with', [rt.new_string(var_field_name.dup().to_string().to_lower()), rt.new_string('scriptmodule')])) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if index > 0 {
			// unsupported expression: Expr_AssignOp_Concat
		}
		return var_asset_handle.dup()
	}
	mut var_field_mappings := rt.create_array([rt.ArrayItem{ key: 'editorScript', val: 'editor-script' }, rt.ArrayItem{ key: 'editorStyle', val: 'editor-style' }, rt.ArrayItem{ key: 'script', val: 'script' }, rt.ArrayItem{ key: 'style', val: 'style' }, rt.ArrayItem{ key: 'viewScript', val: 'view-script' }, rt.ArrayItem{ key: 'viewScriptModule', val: 'view-script-module' }, rt.ArrayItem{ key: 'viewStyle', val: 'view-style' }])
	var_asset_handle = rt.new_string((rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('-'), var_block_name.dup()])).str() + '-' + (var_field_mappings.array_get(var_field_name)).str())
	if index > 0 {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_asset_handle.dup()
}

fn get_block_asset_url(var_path rt.PhpVal) bool {
	mut var_template_paths_norm := rt.new_null()
	if !rt.is_true(var_path) {
		return false
	}
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wpinc_path_norm)))) {
		mut var_wpinc_path_norm := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [rt.concat(rt.get_constant('ABSPATH'), rt.get_constant('WPINC'))])])
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), var_wpinc_path_norm.dup()])) {
		return (rt.call_function('includes_url', [rt.call_function('str_replace', [var_wpinc_path_norm.dup(), rt.new_string(''), var_path.dup()])])).to_bool()
	}
	// unsupported statement: Stmt_Static
	mut var_template := rt.call_function('get_template', []rt.PhpVal{})
	if !(var_template_paths_norm.array_isset(var_template)) {
		var_template_paths_norm.array_set(var_template, rt.call_function('wp_normalize_path', [rt.call_function('realpath', [rt.call_function('get_template_directory', []rt.PhpVal{})])]))
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), rt.call_function('trailingslashit', [var_template_paths_norm.array_get(var_template)])])) {
		return (rt.call_function('get_theme_file_uri', [rt.call_function('str_replace', [var_template_paths_norm.array_get(var_template), rt.new_string(''), var_path.dup()])])).to_bool()
	}
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		mut var_stylesheet := rt.call_function('get_stylesheet', []rt.PhpVal{})
		if !(var_template_paths_norm.array_isset(var_stylesheet)) {
			var_template_paths_norm.array_set(var_stylesheet, rt.call_function('wp_normalize_path', [rt.call_function('realpath', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})])]))
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), rt.call_function('trailingslashit', [var_template_paths_norm.array_get(var_stylesheet)])])) {
			return (rt.call_function('get_theme_file_uri', [rt.call_function('str_replace', [var_template_paths_norm.array_get(var_stylesheet), rt.new_string(''), var_path.dup()])])).to_bool()
		}
	}
	return (rt.call_function('plugins_url', [rt.call_function('basename', [var_path.dup()]), var_path.dup()])).to_bool()
}

fn register_block_script_module_id(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	mut var_module_id := var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_module_id.dup().is_array())) {
		if !rt.is_true(var_module_id.array_get(index)) {
			return false
		}
		var_module_id = var_module_id.array_get(index)
	}
	mut var_module_path := remove_block_asset_path_prefix(var_module_id.dup())
	if rt.is_true(rt.identical(var_module_id, var_module_path)) {
		return (var_module_id).to_bool()
	}
	mut var_path := rt.call_function('dirname', [var_metadata.array_get('file')])
	mut var_module_asset_raw_path := rt.new_string((var_path).str() + '/' + (rt.call_function('substr_replace', [var_module_path.dup(), rt.new_string('.asset.php'), // unsupported expression: Expr_UnaryMinus])).str())
	var_module_id = generate_block_asset_handle(var_metadata.array_get('name'), var_field_name.dup(), index)
	mut var_module_asset_path := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [var_module_asset_raw_path.dup()])])
	mut var_module_path_norm := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [(var_path).str() + '/' + (var_module_path).str()])])
	mut var_module_uri := get_block_asset_url(var_module_path_norm.dup())
	mut var_module_asset := if !(!rt.is_true(var_module_asset_path)) { rt.include_file((var_module_asset_path).to_string(), '3') } else { rt.new_array() }
	mut var_module_dependencies := if !(var_module_asset.array_get('dependencies')).is_null() { var_module_asset.array_get('dependencies') } else { rt.new_array() }
	mut var_block_version := if !(var_metadata.array_get('version')).is_null() { var_metadata.array_get('version') } else { rt.new_bool(false) }
	mut var_module_version := if !(var_module_asset.array_get('version')).is_null() { var_module_asset.array_get('version') } else { var_block_version }
	mut var_supports_interactivity_true := var_metadata.array_get('supports').array_isset(rt.new_string('interactivity')) && rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get('supports').array_get('interactivity')))
	mut var_is_interactive := var_supports_interactivity_true || rt.is_true(rt.new_bool(var_metadata.array_get('supports').array_get('interactivity').array_isset(rt.new_string('interactive')) && rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get('supports').array_get('interactivity').array_get('interactive')))))
	mut var_supports_client_navigation := var_supports_interactivity_true || rt.is_true(rt.new_bool(var_metadata.array_get('supports').array_get('interactivity').array_isset(rt.new_string('clientNavigation')) && rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get('supports').array_get('interactivity').array_get('clientNavigation')))))
	mut var_args := rt.new_array()
	if var_is_interactive {
		var_args['fetchpriority'] = rt.new_string('low')
		var_args['in_footer'] = rt.new_bool(true)
	}
	if var_is_interactive && var_supports_client_navigation {
		rt.call_method(rt.call_function('wp_interactivity', []rt.PhpVal{}), 'add_client_navigation_support_to_script_module', [var_module_id.dup()])
	}
	rt.call_function('wp_register_script_module', [var_module_id.dup(), rt.new_bool(var_module_uri).dup(), var_module_dependencies.dup(), var_module_version.dup(), var_args.dup()])
	return (var_module_id).to_bool()
}

fn register_block_script_handle(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	mut var_script_handle_or_path := var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_script_handle_or_path.dup().is_array())) {
		if !rt.is_true(var_script_handle_or_path.array_get(index)) {
			return false
		}
		var_script_handle_or_path = var_script_handle_or_path.array_get(index)
	}
	mut var_script_path := remove_block_asset_path_prefix(var_script_handle_or_path.dup())
	if rt.is_true(rt.identical(var_script_handle_or_path, var_script_path)) {
		return (var_script_handle_or_path).to_bool()
	}
	mut var_path := rt.call_function('dirname', [var_metadata.array_get('file')])
	mut var_script_asset_raw_path := rt.new_string((var_path).str() + '/' + (rt.call_function('substr_replace', [var_script_path.dup(), rt.new_string('.asset.php'), // unsupported expression: Expr_UnaryMinus])).str())
	mut var_script_asset_path := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [var_script_asset_raw_path.dup()])])
	mut var_script_asset := if !(!rt.is_true(var_script_asset_path)) { rt.include_file((var_script_asset_path).to_string(), '3') } else { rt.new_array() }
	mut var_script_handle := if !(var_script_asset.array_get('handle')).is_null() { var_script_asset.array_get('handle') } else { generate_block_asset_handle(var_metadata.array_get('name'), var_field_name.dup(), index) }
	if rt.is_true(rt.call_function('wp_script_is', [var_script_handle.dup(), rt.new_string('registered')])) {
		return (var_script_handle).to_bool()
	}
	mut var_script_path_norm := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [(var_path).str() + '/' + (var_script_path).str()])])
	mut var_script_uri := get_block_asset_url(var_script_path_norm.dup())
	mut var_script_dependencies := if !(var_script_asset.array_get('dependencies')).is_null() { var_script_asset.array_get('dependencies') } else { rt.new_array() }
	mut var_block_version := if !(var_metadata.array_get('version')).is_null() { var_metadata.array_get('version') } else { rt.new_bool(false) }
	mut var_script_version := if !(var_script_asset.array_get('version')).is_null() { var_script_asset.array_get('version') } else { var_block_version }
	mut var_script_args := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('viewScript'), var_field_name)) && var_script_uri)) {
		var_script_args['strategy'] = 'defer'
	}
	mut var_result := rt.call_function('wp_register_script', [var_script_handle.dup(), rt.new_bool(var_script_uri).dup(), var_script_dependencies.dup(), var_script_version.dup(), var_script_args.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_metadata.array_get('textdomain'))) && rt.is_true(rt.call_function('in_array', [rt.new_string('wp-i18n'), var_script_dependencies.dup(), rt.new_bool(true)])))) {
		rt.call_function('wp_set_script_translations', [var_script_handle.dup(), var_metadata.array_get('textdomain')])
	}
	return (var_script_handle).to_bool()
}

fn register_block_style_handle(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	mut var_style_handle := var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_style_handle.dup().is_array())) {
		if !rt.is_true(var_style_handle.array_get(index)) {
			return false
		}
		var_style_handle = var_style_handle.array_get(index)
	}
	mut var_style_handle_name := generate_block_asset_handle(var_metadata.array_get('name'), var_field_name.dup(), index)
	if rt.is_true(rt.call_function('wp_style_is', [var_style_handle_name.dup(), rt.new_string('registered')])) {
		return (var_style_handle_name).to_bool()
	}
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wpinc_path_norm)))) {
		mut var_wpinc_path_norm := rt.call_function('wp_normalize_path', [rt.call_function('realpath', [rt.concat(rt.get_constant('ABSPATH'), rt.get_constant('WPINC'))])])
	}
	mut var_is_core_block := var_metadata.array_isset(rt.new_string('file')) && rt.is_true(rt.call_function('str_starts_with', [var_metadata.array_get('file'), var_wpinc_path_norm.dup()]))
	if rt.is_true(rt.new_bool(var_is_core_block && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets', []rt.PhpVal{}))))))) {
		return false
	}
	mut var_style_path := remove_block_asset_path_prefix(var_style_handle.dup())
	mut var_is_style_handle := (rt.identical(var_style_handle, var_style_path)).to_bool()
	if var_is_core_block && !(var_is_style_handle) {
		return false
	}
	if var_is_style_handle && !(var_is_core_block && 0 == index) {
		return (var_style_handle).to_bool()
	}
	mut var_suffix := if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	if var_is_core_block {
		var_style_path = rt.new_string(if rt.is_true() {  } else {  })
	}
	mut var_style_path_norm := rt.call_function('wp_normalize_path', [])
	mut var_style_uri := 
	
}

fn init_registry() {
	rt.register_func('remove_block_asset_path_prefix', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return remove_block_asset_path_prefix(arg_0)
	})
	rt.register_func('generate_block_asset_handle', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return generate_block_asset_handle(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_block_asset_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(get_block_asset_url(arg_0))
	})
	rt.register_func('register_block_script_module_id', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_script_module_id(arg_0, arg_1, arg_2))
	})
	rt.register_func('register_block_script_handle', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_script_handle(arg_0, arg_1, arg_2))
	})
	rt.register_func('register_block_style_handle', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_style_handle(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_block_metadata_i18n_schema', fn(args []rt.PhpVal) rt.PhpVal {
		return get_block_metadata_i18n_schema()
	})
	rt.register_func('wp_register_block_types_from_metadata_collection', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_register_block_types_from_metadata_collection(arg_0, arg_1)
	})
	rt.register_func('wp_register_block_metadata_collection', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_register_block_metadata_collection(arg_0, arg_1)
	})
	rt.register_func('register_block_type_from_metadata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(register_block_type_from_metadata(arg_0, arg_1))
	})
	rt.register_func('register_block_type', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(register_block_type(arg_0, arg_1))
	})
	rt.register_func('unregister_block_type', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_block_type(arg_0)
	})
	rt.register_func('has_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(has_blocks(arg_0))
	})
	rt.register_func('has_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(has_block(arg_0, arg_1))
	})
	rt.register_func('get_dynamic_block_names', fn(args []rt.PhpVal) rt.PhpVal {
		return get_dynamic_block_names()
	})
	rt.register_func('get_hooked_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		return get_hooked_blocks()
	})
	rt.register_func('insert_hooked_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(insert_hooked_blocks(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('set_ignored_hooked_blocks_metadata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(set_ignored_hooked_blocks_metadata(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('apply_block_hooks_to_content', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return apply_block_hooks_to_content(arg_0, arg_1, arg_2)
	})
	rt.register_func('apply_block_hooks_to_content_from_post_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return apply_block_hooks_to_content_from_post_object(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('remove_serialized_parent_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return remove_serialized_parent_block(arg_0)
	})
	rt.register_func('extract_serialized_parent_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(extract_serialized_parent_block(arg_0))
	})
	rt.register_func('update_ignored_hooked_blocks_postmeta', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return update_ignored_hooked_blocks_postmeta(arg_0)
	})
	rt.register_func('insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('insert_hooked_blocks_into_rest_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return insert_hooked_blocks_into_rest_response(arg_0, arg_1)
	})
	rt.register_func('make_before_block_visitor', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return make_before_block_visitor(arg_0, arg_1, arg_2)
	})
	rt.register_func('make_after_block_visitor', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return make_after_block_visitor(arg_0, arg_1, arg_2)
	})
	rt.register_func('serialize_block_attributes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_block_attributes(arg_0)
	})
	rt.register_func('strip_core_block_namespace', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return strip_core_block_namespace(arg_0)
	})
	rt.register_func('get_comment_delimited_block_content', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return get_comment_delimited_block_content(arg_0, arg_1, arg_2)
	})
	rt.register_func('serialize_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_block(arg_0)
	})
	rt.register_func('serialize_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_blocks(arg_0)
	})
	rt.register_func('traverse_and_serialize_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return traverse_and_serialize_block(arg_0, arg_1, arg_2)
	})
	rt.register_func('resolve_pattern_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return resolve_pattern_blocks(arg_0)
	})
	rt.register_func('traverse_and_serialize_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_string(traverse_and_serialize_blocks(arg_0, arg_1, arg_2))
	})
	rt.register_func('filter_block_content', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_string(filter_block_content(arg_0, arg_1, arg_2))
	})
	rt.register_func('_filter_block_content_callback', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_filter_block_content_callback(arg_0))
	})
	rt.register_func('filter_block_kses', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return filter_block_kses(arg_0, arg_1, arg_2)
	})
	rt.register_func('filter_block_kses_value', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return filter_block_kses_value(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('filter_block_core_template_part_attributes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return filter_block_core_template_part_attributes(arg_0, arg_1, arg_2)
	})
	rt.register_func('excerpt_remove_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(excerpt_remove_blocks(arg_0))
	})
	rt.register_func('excerpt_remove_footnotes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return excerpt_remove_footnotes(arg_0)
	})
	rt.register_func('_excerpt_render_inner_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(_excerpt_render_inner_blocks(arg_0, arg_1))
	})
	rt.register_func('render_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return render_block(arg_0)
	})
	rt.register_func('parse_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return parse_blocks(arg_0)
	})
	rt.register_func('do_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(do_blocks(arg_0))
	})
	rt.register_func('_restore_wpautop_hook', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _restore_wpautop_hook(arg_0)
	})
	rt.register_func('block_version', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(block_version(arg_0))
	})
	rt.register_func('register_block_style', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return register_block_style(arg_0, arg_1)
	})
	rt.register_func('unregister_block_style', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return unregister_block_style(arg_0, arg_1)
	})
	rt.register_func('block_has_support', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(block_has_support(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_migrate_old_typography_shape', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_migrate_old_typography_shape(arg_0)
	})
	rt.register_func('build_query_vars_from_query_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return build_query_vars_from_query_block(arg_0, arg_1)
	})
	rt.register_func('get_query_pagination_arrow', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return get_query_pagination_arrow(arg_0, arg_1)
	})
	rt.register_func('build_comment_query_vars_from_block', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return build_comment_query_vars_from_block(arg_0)
	})
	rt.register_func('get_comments_pagination_arrow', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return get_comments_pagination_arrow(arg_0, arg_1)
	})
	rt.register_func('_wp_filter_post_meta_footnotes', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_wp_filter_post_meta_footnotes(arg_0))
	})
	rt.register_func('_wp_footnotes_kses_init_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_kses_init_filters()
	})
	rt.register_func('_wp_footnotes_remove_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_remove_filters()
	})
	rt.register_func('_wp_footnotes_kses_init', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_kses_init()
	})
	rt.register_func('_wp_footnotes_force_filtered_html_on_import_filter', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_footnotes_force_filtered_html_on_import_filter(arg_0)
	})
	rt.register_func('_wp_enqueue_auto_register_blocks', fn(args []rt.PhpVal) rt.PhpVal {
		return _wp_enqueue_auto_register_blocks()
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
