import rt

const global_const_blocks_path =
	(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/blocks/'

fn register_core_block_style_handles() {
	mut var_wp_version := rt.new_null()
	mut var_blocks_url := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_wp_styles := rt.new_null()
	mut var_style_fields := map[string]rt.PhpVal{}
	mut var_core_blocks_meta := rt.new_null()
	mut var_files := rt.new_null()
	mut var_transient_name := ''
	mut var_can_use_cached := false
	mut var_cached_files := rt.new_null()
	mut var_normalized_blocks_path := rt.new_null()
	mut var_register_style := rt.new_null()
	mut var_schema := rt.new_null()
	mut var_name := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_style_field := rt.new_null()
	mut var_style_handle := rt.new_null()
	var_wp_version = rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets',
		[]rt.PhpVal{})))))
	{
		return
	}
	var_blocks_url = rt.call_function('includes_url', [rt.new_string('blocks/')])
	var_suffix = rt.call_function('wp_scripts_get_suffix', []rt.PhpVal{})
	var_wp_styles = rt.call_function('wp_styles', []rt.PhpVal{})
	var_style_fields = {
		'style':       'style'
		'editorStyle': 'editor'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_core_blocks_meta)))) {
		var_core_blocks_meta = rt.include_file(global_const_blocks_path + 'blocks-json.php', '3')
	}
	var_files = rt.new_bool(false)
	var_transient_name = 'wp_core_block_css_files'
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('core'),
	])))
	if var_can_use_cached {
		var_cached_files = rt.call_function('get_transient', [
			rt.new_string(var_transient_name.str()).clone()])
		if var_cached_files.clone().is_array()
			&& var_cached_files.array_isset(rt.new_string('version'))
			&& rt.is_true(rt.identical(var_cached_files.array_get(rt.new_string('version')), var_wp_version))
			&& var_cached_files.array_isset(rt.new_string('files')) {
			var_files = var_cached_files.array_get(rt.new_string('files'))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_files)))) {
		var_files = rt.call_function('glob', [
			rt.call_function('wp_normalize_path', [
				rt.new_string(global_const_blocks_path + '**/**.css'),
			]),
		])
		var_normalized_blocks_path = rt.call_function('wp_normalize_path', [
			rt.new_string(global_const_blocks_path),
		])
		closure_1_fn := fn [var_normalized_blocks_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		closure_2_fn := fn [var_normalized_blocks_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_file := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		var_files = rt.call_function('array_map', [rt.new_closure(closure_1_fn),
			var_files.clone()])
		if var_can_use_cached {
			rt.call_function('set_transient', [rt.new_string(var_transient_name.str()).clone(),
				rt.create_array([rt.ArrayItem{ key: 'version', val: var_wp_version },
					rt.ArrayItem{ key: 'files', val: var_files }])])
		}
	}
	closure_3_fn := fn [var_blocks_url, var_suffix, var_wp_styles, var_files] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_filename := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_style_handle := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_style_path :=
			rt.new_string('${var_name.to_string()}/${var_filename.to_string()}${var_suffix.to_string()}.css')
		mut var_path := rt.call_function('wp_normalize_path', [
			rt.new_string(global_const_blocks_path + var_style_path.str()),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_style_path.clone(), var_files.clone(), rt.new_bool(true)])))))
		{
			rt.call_method(var_wp_styles, 'add', [var_style_handle.clone(),
				rt.new_bool(false)])
			return
		}
		rt.call_method(var_wp_styles, 'add', [var_style_handle.clone(),
			rt.new_string(var_blocks_url.str() + var_style_path.str())])
		rt.call_method(var_wp_styles, 'add_data', [var_style_handle.clone(),
			rt.new_string('path'), var_path.clone()])
		mut var_rtl_file :=
			rt.new_string('${var_name.to_string()}/${var_filename.to_string()}-rtl${var_suffix.to_string()}.css')
		if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('in_array', [var_rtl_file.clone(), var_files.clone(), rt.new_bool(true)])) {
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.clone(),
				rt.new_string('rtl'), rt.new_string('replace')])
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.clone(),
				rt.new_string('suffix'), var_suffix.clone()])
			rt.call_method(var_wp_styles, 'add_data', [var_style_handle.clone(),
				rt.new_string('path'),
				rt.call_function('str_replace', [
					rt.new_string('${var_suffix.to_string()}.css'),
					rt.new_string('-rtl${var_suffix.to_string()}.css'),
					var_path.clone(),
				])])
		}
		return rt.new_null()
	}
	var_register_style = rt.new_closure(closure_3_fn)
	mut iter_1 := var_core_blocks_meta.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_schema_shadow := item_1.val
		mut var_name_shadow := item_1.key
		var_schema_shadow = rt.call_function('apply_filters', [
			rt.new_string('block_type_metadata'),
			var_schema_shadow.clone(),
		])
		if !(var_schema_shadow.array_isset(rt.new_string('style'))) {
			var_schema_shadow.array_set('style', 'wp-block-${var_name.to_string()}')
		}
		if !(var_schema_shadow.array_isset(rt.new_string('editorStyle'))) {
			var_schema_shadow.array_set('editorStyle', 'wp-block-${var_name.to_string()}-editor')
		}
		rt.call_callable(var_register_style, [var_name_shadow.clone(),
			rt.new_string('theme'), rt.new_string('wp-block-${var_name.to_string()}-theme')])
		for var_style_field_shadow, var_filename_shadow in var_style_fields {
			var_style_handle =
				var_schema_shadow.array_get(rt.new_string(var_style_field_shadow.str()))
			if rt.is_true(rt.new_bool(var_style_handle.clone().is_array())) {
				continue
			}
			rt.call_callable(var_register_style, [var_name_shadow.clone(),
				rt.new_string(var_filename_shadow.str()).clone(),
				var_style_handle.clone()])
		}
	}
}

fn register_core_block_types_from_metadata() {
	mut var_block_folders := rt.new_null()
	mut var_block_folder := rt.new_null()
	var_block_folders = rt.include_file(global_const_blocks_path + 'require-static-blocks.php', '3')
	mut iter_2 := var_block_folders.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block_folder_shadow := item_2.val
		rt.call_function('register_block_type_from_metadata', [
			rt.new_string(global_const_blocks_path + var_block_folder_shadow.str()),
		])
	}
}

fn wp_register_core_block_metadata_collection() {
	rt.call_function('wp_register_block_metadata_collection', [
		rt.new_string(global_const_blocks_path),
		rt.new_string(global_const_blocks_path + 'blocks-json.php'),
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
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
