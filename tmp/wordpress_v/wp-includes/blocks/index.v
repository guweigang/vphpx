import rt

const global_const_blocks_path =
	(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/blocks/'

fn register_core_block_style_handles() {
	mut var_wp_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets',
		[]rt.PhpVal{})))))
	{
		return rt.new_null()
	}
	mut var_blocks_url := rt.call_function('includes_url', [rt.new_string('blocks/')])
	mut var_suffix := rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})
	mut var_wp_styles := rt.call_function('wp_styles', []rt.PhpVal{})
	mut var_style_fields := {
		'style':       'style'
		'editorStyle': 'editor'
	}
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(var_core_blocks_meta)))) {
		mut var_core_blocks_meta :=
			rt.include_file(global_const_blocks_path + 'blocks-json.php', '3')
	}
	mut var_files := rt.new_bool(rt.new_bool(false))
	mut var_transient_name := 'wp_core_block_css_files'
	mut var_can_use_cached := !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('core'),
	])))
	if var_can_use_cached {
		mut var_cached_files := rt.call_function('get_transient', [
			rt.new_string(var_transient_name).dup()])
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cached_files.dup().is_array()))
			&& var_cached_files.array_isset(rt.new_string('version'))))
			&& rt.is_true(rt.identical(var_cached_files.array_get('version'), var_wp_version))))
			&& var_cached_files.array_isset(rt.new_string('files'))))
		{
			var_files = var_cached_files.array_get('files')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		var_files = rt.call_function('glob', [
			rt.call_function('wp_normalize_path', [
				global_const_blocks_path + '**/**.css',
			]),
		])
		mut var_normalized_blocks_path := rt.call_function('wp_normalize_path', [
			rt.new_string(global_const_blocks_path),
		])
		closure_2_fn := fn [var_normalized_blocks_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			closure_1_fn := fn [var_normalized_blocks_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return rt.call_function('str_replace', [var_normalized_blocks_path.dup(),
					rt.new_string(''), var_file.dup()])
			}
			mut var_file := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('str_replace', [var_normalized_blocks_path.dup(),
				rt.new_string(''), var_file.dup()])
		}
		var_files = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			var_files.dup()])
		if var_can_use_cached {
			rt.call_function('set_transient', [rt.new_string(var_transient_name).dup(),
				rt.create_array([rt.ArrayItem{ key: 'version', val: var_wp_version },
					rt.ArrayItem{ key: 'files', val: var_files }])])
		}
	}
	closure_3_fn := fn [var_blocks_url, var_suffix, var_wp_styles, var_files] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_filename := if args.len > 1 { args[1].dup() } else { rt.new_null() }
		mut var_style_handle := if args.len > 2 { args[2].dup() } else { rt.new_null() }
		mut var_style_path :=
			rt.new_string(rt.new_string('${var_name.to_string()}/${var_filename.to_string()}${var_suffix.to_string()}.css'))
		mut var_path := rt.call_function('wp_normalize_path', [
			global_const_blocks_path + var_style_path.str(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_style_path.dup(), var_files.dup(), rt.new_bool(true)])))))
		{
			rt.call_method(var_wp_styles, 'add', [var_style_handle.dup(),
				rt.new_bool(false)])
			return rt.new_null()
		}
		rt.call_method(var_wp_styles, 'add', [var_style_handle.dup(),
			rt.concat(var_blocks_url, var_style_path)])
		rt.call_method(var_wp_styles, 'add_data', [var_style_handle.dup(),
			rt.new_string('path'), var_path.dup()])
		mut var_rtl_file :=
			rt.new_string(rt.new_string('${var_name.to_string()}/${var_filename.to_string()}-rtl${var_suffix.to_string()}.css'))
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('in_array', [var_rtl_file.dup(), var_files.dup(), rt.new_bool(true)]))))
		{
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.dup(),
				rt.new_string('rtl'), rt.new_string('replace')])
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.dup(),
				rt.new_string('suffix'), var_suffix.dup()])
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.dup(),
				rt.new_string('path'),
				rt.call_function('str_replace', [
					rt.new_string('${var_suffix.to_string()}.css'),
					rt.new_string('-rtl${var_suffix.to_string()}.css'),
					var_path.dup(),
				])])
		}
		return rt.new_null()
	}
	mut var_register_style := rt.new_closure(closure_3_fn)
	{
		mut iter_1 := var_core_blocks_meta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_schema := item_1.val
			mut var_name := item_1.key
			var_schema = rt.call_function('apply_filters', [
				rt.new_string('block_type_metadata'),
				var_schema.dup(),
			])
			if !(var_schema.array_isset(rt.new_string('style'))) {
				var_schema.array_set('style', 'wp-block-${var_name.to_string()}')
			}
			if !(var_schema.array_isset(rt.new_string('editorStyle'))) {
				var_schema.array_set('editorStyle', 'wp-block-${var_name.to_string()}-editor')
			}
			rt.call_callable(var_register_style, [var_name.dup(),
				rt.new_string('theme'), rt.new_string('wp-block-${var_name.to_string()}-theme')])
			for var_style_field, var_filename in var_style_fields {
				mut var_style_handle := var_schema.array_get(style_field)
				if rt.is_true(rt.new_bool(var_style_handle.dup().is_array())) {
					continue
				}
				rt.call_callable(var_register_style, [var_name.dup(),
					rt.new_string(filename), var_style_handle.dup()])
			}
		}
	}
}

fn register_core_block_types_from_metadata() {
	mut var_block_folders :=
		rt.include_file(global_const_blocks_path + 'require-static-blocks.php', '3')
	{
		mut iter_1 := var_block_folders.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_folder := item_1.val
			rt.call_function('register_block_type_from_metadata', [
				global_const_blocks_path + var_block_folder.str(),
			])
		}
	}
}

fn wp_register_core_block_metadata_collection() {
	rt.call_function('wp_register_block_metadata_collection', [
		rt.new_string(global_const_blocks_path),
		global_const_blocks_path + 'blocks-json.php',
	])
}

fn init_registry() {
	rt.register_func('register_core_block_style_handles', fn (args []rt.PhpVal) rt.PhpVal {
		return register_core_block_style_handles()
	})
	rt.register_func('register_core_block_types_from_metadata', fn (args []rt.PhpVal) rt.PhpVal {
		return register_core_block_types_from_metadata()
	})
	rt.register_func('wp_register_core_block_metadata_collection', fn (args []rt.PhpVal) rt.PhpVal {
		return wp_register_core_block_metadata_collection()
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_includes_blocks_index_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	rt.include_file(global_const_blocks_path + 'legacy-widget.php', '3')
	rt.include_file(global_const_blocks_path + 'widget-group.php', '3')
	rt.include_file(global_const_blocks_path + 'require-dynamic-blocks.php', '3')
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_core_block_style_handles'), rt.new_int(9)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_core_block_types_from_metadata')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('wp_register_core_block_metadata_collection'),
		rt.new_int(9)])
}
