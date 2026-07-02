import rt

fn remove_block_asset_path_prefix(var_asset_handle_or_path rt.PhpVal) rt.PhpVal {
	mut var_path_prefix := ''
	mut var_path := rt.new_null()
	var_path_prefix = 'file:'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
		var_asset_handle_or_path.clone(),
		rt.new_string(var_path_prefix.str()).clone(),
	])))))
	{
		return var_asset_handle_or_path.clone()
	}
	var_path = rt.call_function('substr', [var_asset_handle_or_path.clone(),
		rt.new_int(var_path_prefix.len)])
	if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(),
		rt.new_string('./')]))
	{
		var_path = rt.call_function('substr', [var_path.clone(),
			rt.new_int(2)])
	}
	return var_path.clone()
}

fn generate_block_asset_handle(var_block_name rt.PhpVal, var_field_name rt.PhpVal, index i64) rt.PhpVal {
	mut var_index := index
	mut var_asset_handle := rt.new_null()
	mut var_field_mappings := rt.new_null()
	if rt.is_true(rt.call_function('str_starts_with', [var_block_name.clone(),
		rt.new_string('core/')]))
	{
		var_asset_handle = rt.call_function('str_replace', [rt.new_string('core/'),
			rt.new_string('wp-block-'), var_block_name.clone()])
		if rt.is_true(rt.call_function('str_starts_with', [var_field_name.clone(),
			rt.new_string('editor')]))
		{
			var_asset_handle = rt.concat(var_asset_handle, rt.new_string('-editor'))
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_field_name.clone(),
			rt.new_string('view')]))
		{
			var_asset_handle = rt.concat(var_asset_handle, rt.new_string('-view'))
		}
		if rt.is_true(rt.call_function('str_ends_with', [
			rt.new_string(var_field_name.clone().to_string().to_lower()),
			rt.new_string('scriptmodule'),
		]))
		{
			var_asset_handle = rt.concat(var_asset_handle, rt.new_string('-script-module'))
		}
		if index > 0 {
			var_asset_handle = rt.concat(var_asset_handle, rt.new_string('-' + index + 1.str()))
		}
		return var_asset_handle.clone()
	}
	var_field_mappings = rt.create_array([
		rt.ArrayItem{ key: 'editorScript', val: 'editor-script' },
		rt.ArrayItem{ key: 'editorStyle', val: 'editor-style' },
		rt.ArrayItem{ key: 'script', val: 'script' },
		rt.ArrayItem{ key: 'style', val: 'style' },
		rt.ArrayItem{ key: 'viewScript', val: 'view-script' },
		rt.ArrayItem{ key: 'viewScriptModule', val: 'view-script-module' },
		rt.ArrayItem{ key: 'viewStyle', val: 'view-style' },
	])
	var_asset_handle = rt.new_string(
		(rt.call_function('str_replace', [rt.new_string('/'), rt.new_string('-'), var_block_name.clone()])).str() +
		'-' + (var_field_mappings.array_get(var_field_name)).str())
	if index > 0 {
		var_asset_handle = rt.concat(var_asset_handle, rt.new_string('-' + index + 1.str()))
	}
	return var_asset_handle.clone()
}

fn get_block_asset_url(var_path rt.PhpVal) bool {
	mut var_template_paths_norm := rt.new_null()
	mut var_wpinc_path_norm := rt.new_null()
	mut var_template := rt.new_null()
	mut var_stylesheet := rt.new_null()
	if !rt.is_true(var_path) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wpinc_path_norm)))) {
		var_wpinc_path_norm = rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [
				rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str()),
			]),
		])
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(),
		var_wpinc_path_norm.clone()]))
	{
		return (rt.call_function('includes_url', [
			rt.call_function('str_replace', [var_wpinc_path_norm.clone(),
				rt.new_string(''), var_path.clone()]),
		])).to_bool()
	}
	var_template = rt.call_function('get_template', []rt.PhpVal{})
	if !(var_template_paths_norm.array_isset(var_template)) {
		var_template_paths_norm.array_set(var_template, rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [
				rt.call_function('get_template_directory', []rt.PhpVal{}),
			]),
		]))
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(),
		rt.call_function('trailingslashit', [var_template_paths_norm.array_get(var_template)])]))
	{
		return (rt.call_function('get_theme_file_uri', [
			rt.call_function('str_replace', [var_template_paths_norm.array_get(var_template),
				rt.new_string(''), var_path.clone()]),
		])).to_bool()
	}
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		var_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
		if !(var_template_paths_norm.array_isset(var_stylesheet)) {
			var_template_paths_norm.array_set(var_stylesheet, rt.call_function('wp_normalize_path', [
				rt.call_function('realpath', [
					rt.call_function('get_stylesheet_directory', []rt.PhpVal{}),
				]),
			]))
		}
		if rt.is_true(rt.call_function('str_starts_with', [var_path.clone(),
			rt.call_function('trailingslashit', [var_template_paths_norm.array_get(var_stylesheet)])]))
		{
			return (rt.call_function('get_theme_file_uri', [
				rt.call_function('str_replace', [var_template_paths_norm.array_get(var_stylesheet),
					rt.new_string(''), var_path.clone()]),
			])).to_bool()
		}
	}
	return (rt.call_function('plugins_url', [
		rt.call_function('basename', [var_path.clone()]),
		var_path.clone(),
	])).to_bool()
}

fn register_block_script_module_id(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	mut var_index := index
	mut var_module_id := rt.new_null()
	mut var_module_path := rt.new_null()
	mut var_path := rt.new_null()
	mut var_module_asset_raw_path := rt.new_null()
	mut var_module_asset_path := rt.new_null()
	mut var_module_path_norm := rt.new_null()
	mut var_module_uri := false
	mut var_module_asset := rt.new_null()
	mut var_module_dependencies := rt.new_null()
	mut var_block_version := rt.new_null()
	mut var_module_version := rt.new_null()
	mut var_supports_interactivity_true := false
	mut var_is_interactive := false
	mut var_supports_client_navigation := false
	mut var_args := map[string]rt.PhpVal{}
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	var_module_id = var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_module_id.clone().is_array())) {
		if !rt.is_true(var_module_id.array_get(rt.new_int(index))) {
			return false
		}
		var_module_id = var_module_id.array_get(rt.new_int(index))
	}
	var_module_path = remove_block_asset_path_prefix(var_module_id.clone())
	if rt.is_true(rt.identical(var_module_id, var_module_path)) {
		return var_module_id.to_bool()
	}
	var_path = rt.call_function('dirname', [var_metadata.array_get(rt.new_string('file'))])
	var_module_asset_raw_path =
		rt.new_string(var_path.str() + '/' +(rt.call_function('substr_replace', [var_module_path.clone(), rt.new_string('.asset.php'), rt.new_int(-'.js'.len)])).str())
	var_module_id = generate_block_asset_handle(var_metadata.array_get(rt.new_string('name')),
		var_field_name.clone(), index)
	var_module_asset_path = rt.call_function('wp_normalize_path', [
		rt.call_function('realpath', [var_module_asset_raw_path.clone()]),
	])
	var_module_path_norm = rt.call_function('wp_normalize_path', [
		rt.call_function('realpath', [
			rt.new_string(var_path.str() + '/' + var_module_path.str()),
		]),
	])
	var_module_uri = get_block_asset_url(var_module_path_norm.clone())
	var_module_asset = if !(!rt.is_true(var_module_asset_path)) {
		rt.include_file(var_module_asset_path.to_string(), '3')
	} else {
		rt.new_array()
	}
	var_module_dependencies = if !(var_module_asset.array_get(rt.new_string('dependencies'))).is_null() {
		var_module_asset.array_get(rt.new_string('dependencies'))
	} else {
		rt.new_array()
	}
	var_block_version = if !(var_metadata.array_get(rt.new_string('version'))).is_null() {
		var_metadata.array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_module_version = if !(var_module_asset.array_get(rt.new_string('version'))).is_null() {
		var_module_asset.array_get(rt.new_string('version'))
	} else {
		var_block_version
	}
	var_supports_interactivity_true =
		var_metadata.array_get(rt.new_string('supports')).array_isset(rt.new_string('interactivity'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('interactivity'))))
	var_is_interactive = var_supports_interactivity_true
		|| var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('interactivity')).array_isset(rt.new_string('interactive'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('interactivity')).array_get(rt.new_string('interactive'))))
	var_supports_client_navigation = var_supports_interactivity_true
		|| var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('interactivity')).array_isset(rt.new_string('clientNavigation'))
		&& rt.is_true(rt.identical(rt.new_bool(true), var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string('interactivity')).array_get(rt.new_string('clientNavigation'))))
	var_args = rt.new_array()
	if var_is_interactive {
		var_args['fetchpriority'] = rt.new_string('low')
		var_args['in_footer'] = rt.new_bool(true)
	}
	if var_is_interactive && var_supports_client_navigation {
		rt.call_method(rt.call_function('wp_interactivity', []rt.PhpVal{}),
			'add_client_navigation_support_to_script_module', [
			var_module_id.clone()])
	}
	rt.call_function('wp_register_script_module', [var_module_id.clone(),
		rt.new_bool(var_module_uri).clone(), var_module_dependencies.clone(),
		var_module_version.clone(), rt.create_array_from_native_map(var_args)])
	return var_module_id.to_bool()
}

fn register_block_script_handle(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	mut var_index := index
	mut var_script_handle_or_path := rt.new_null()
	mut var_script_path := rt.new_null()
	mut var_path := rt.new_null()
	mut var_script_asset_raw_path := rt.new_null()
	mut var_script_asset_path := rt.new_null()
	mut var_script_asset := rt.new_null()
	mut var_script_handle := rt.new_null()
	mut var_script_path_norm := rt.new_null()
	mut var_script_uri := false
	mut var_script_dependencies := rt.new_null()
	mut var_block_version := rt.new_null()
	mut var_script_version := rt.new_null()
	mut var_script_args := map[string]rt.PhpVal{}
	mut var_result := rt.new_null()
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	var_script_handle_or_path = var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_script_handle_or_path.clone().is_array())) {
		if !rt.is_true(var_script_handle_or_path.array_get(rt.new_int(index))) {
			return false
		}
		var_script_handle_or_path = var_script_handle_or_path.array_get(rt.new_int(index))
	}
	var_script_path = remove_block_asset_path_prefix(var_script_handle_or_path.clone())
	if rt.is_true(rt.identical(var_script_handle_or_path, var_script_path)) {
		return var_script_handle_or_path.to_bool()
	}
	var_path = rt.call_function('dirname', [var_metadata.array_get(rt.new_string('file'))])
	var_script_asset_raw_path =
		rt.new_string(var_path.str() + '/' +(rt.call_function('substr_replace', [var_script_path.clone(), rt.new_string('.asset.php'), rt.new_int(-'.js'.len)])).str())
	var_script_asset_path = rt.call_function('wp_normalize_path', [
		rt.call_function('realpath', [var_script_asset_raw_path.clone()]),
	])
	var_script_asset = if !(!rt.is_true(var_script_asset_path)) {
		rt.include_file(var_script_asset_path.to_string(), '3')
	} else {
		rt.new_array()
	}
	var_script_handle = if !(var_script_asset.array_get(rt.new_string('handle'))).is_null() {
		var_script_asset.array_get(rt.new_string('handle'))
	} else {
		generate_block_asset_handle(var_metadata.array_get(rt.new_string('name')),
			var_field_name.clone(), index)
	}
	if rt.is_true(rt.call_function('wp_script_is', [var_script_handle.clone(),
		rt.new_string('registered')]))
	{
		return var_script_handle.to_bool()
	}
	var_script_path_norm = rt.call_function('wp_normalize_path', [
		rt.call_function('realpath', [
			rt.new_string(var_path.str() + '/' + var_script_path.str()),
		]),
	])
	var_script_uri = get_block_asset_url(var_script_path_norm.clone())
	var_script_dependencies = if !(var_script_asset.array_get(rt.new_string('dependencies'))).is_null() {
		var_script_asset.array_get(rt.new_string('dependencies'))
	} else {
		rt.new_array()
	}
	var_block_version = if !(var_metadata.array_get(rt.new_string('version'))).is_null() {
		var_metadata.array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_script_version = if !(var_script_asset.array_get(rt.new_string('version'))).is_null() {
		var_script_asset.array_get(rt.new_string('version'))
	} else {
		var_block_version
	}
	var_script_args = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('viewScript'), var_field_name)) && var_script_uri {
		var_script_args['strategy'] = 'defer'
	}
	var_result = rt.call_function('wp_register_script', [var_script_handle.clone(),
		rt.new_bool(var_script_uri).clone(), var_script_dependencies.clone(),
		var_script_version.clone(), rt.create_array_from_native_map(var_script_args)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('textdomain'))))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('wp-i18n'), var_script_dependencies.clone(), rt.new_bool(true)])) {
		rt.call_function('wp_set_script_translations', [var_script_handle.clone(),
			var_metadata.array_get(rt.new_string('textdomain'))])
	}
	return var_script_handle.to_bool()
}

fn register_block_style_handle(var_metadata rt.PhpVal, var_field_name rt.PhpVal, index i64) bool {
	mut var_index := index
	mut var_style_handle := rt.new_null()
	mut var_style_handle_name := rt.new_null()
	mut var_wpinc_path_norm := rt.new_null()
	mut var_is_core_block := false
	mut var_style_path := rt.new_null()
	mut var_is_style_handle := false
	mut var_suffix := ''
	mut var_style_path_norm := rt.new_null()
	mut var_style_uri := false
	mut var_block_version := rt.new_null()
	mut var_version := rt.new_null()
	mut var_result := rt.new_null()
	mut var_rtl_file := rt.new_null()
	if !rt.is_true(var_metadata.array_get(var_field_name)) {
		return false
	}
	var_style_handle = var_metadata.array_get(var_field_name)
	if rt.is_true(rt.new_bool(var_style_handle.clone().is_array())) {
		if !rt.is_true(var_style_handle.array_get(rt.new_int(index))) {
			return false
		}
		var_style_handle = var_style_handle.array_get(rt.new_int(index))
	}
	var_style_handle_name = generate_block_asset_handle(var_metadata.array_get(rt.new_string('name')),
		var_field_name.clone(), index)
	if rt.is_true(rt.call_function('wp_style_is', [var_style_handle_name.clone(),
		rt.new_string('registered')]))
	{
		return var_style_handle_name.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wpinc_path_norm)))) {
		var_wpinc_path_norm = rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [
				rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str()),
			]),
		])
	}
	var_is_core_block = var_metadata.array_isset(rt.new_string('file'))
		&& rt.is_true(rt.call_function('str_starts_with', [var_metadata.array_get(rt.new_string('file')), var_wpinc_path_norm.clone()]))
	if var_is_core_block
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets', []rt.PhpVal{}))))) {
		return false
	}
	var_style_path = remove_block_asset_path_prefix(var_style_handle.clone())
	var_is_style_handle = (rt.identical(var_style_handle, var_style_path)).to_bool()
	if var_is_core_block && !var_is_style_handle {
		return false
	}
	if var_is_style_handle && !(var_is_core_block && 0 == index) {
		return var_style_handle.to_bool()
	}
	var_suffix = if rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { '' } else { '.min' }
	if var_is_core_block {
		var_style_path = rt.new_string((if rt.is_true(rt.identical(rt.new_string('editorStyle'),
			var_field_name))
		{
			'editor${var_suffix}.css'
		} else {
			'style${var_suffix}.css'
		}).str())
	}
	var_style_path_norm = rt.call_function('wp_normalize_path', [
		rt.call_function('realpath', [
			rt.new_string(
				(rt.call_function('dirname', [var_metadata.array_get(rt.new_string('file'))])).str() +
				'/' + var_style_path.str()),
		]),
	])
	var_style_uri = get_block_asset_url(var_style_path_norm.clone())
	var_block_version = if !var_is_core_block && var_metadata.array_isset(rt.new_string('version')) {
		var_metadata.array_get(rt.new_string('version'))
	} else {
		rt.new_bool(false)
	}
	var_version = if rt.is_true(var_style_path_norm) && rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')])) && rt.is_true(rt.get_constant('SCRIPT_DEBUG')) { rt.call_function('filemtime', [
			var_style_path_norm.clone(),
		]) } else { var_block_version }
	var_result = rt.call_function('wp_register_style', [var_style_handle_name.clone(),
		rt.new_bool(var_style_uri).clone(), rt.new_array(), var_version.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	if var_style_uri {
		rt.call_function('wp_style_add_data', [var_style_handle_name.clone(),
			rt.new_string('path'), var_style_path_norm.clone()])
		if var_is_core_block {
			var_rtl_file = rt.call_function('str_replace', [
				rt.new_string('${var_suffix}.css'),
				rt.new_string('-rtl${var_suffix}.css'),
				var_style_path_norm.clone(),
			])
		} else {
			var_rtl_file = rt.call_function('str_replace', [rt.new_string('.css'),
				rt.new_string('-rtl.css'), var_style_path_norm.clone()])
		}
		if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('file_exists', [var_rtl_file.clone()])) {
			rt.call_function('wp_style_add_data', [var_style_handle_name.clone(),
				rt.new_string('rtl'), rt.new_string('replace')])
			rt.call_function('wp_style_add_data', [var_style_handle_name.clone(),
				rt.new_string('suffix'), rt.new_string(var_suffix.str()).clone()])
			rt.call_function('wp_style_add_data', [var_style_handle_name.clone(),
				rt.new_string('path'), var_rtl_file.clone()])
		}
	}
	return var_style_handle_name.to_bool()
}

fn get_block_metadata_i18n_schema() rt.PhpVal {
	mut var_i18n_block_schema := rt.new_null()
	if !(!var_i18n_block_schema.is_null()) {
		var_i18n_block_schema = rt.call_function('wp_json_file_decode', [
			rt.new_string(@DIR + '/block-i18n.json'),
		])
	}
	return var_i18n_block_schema.clone()
}

fn wp_register_block_types_from_metadata_collection(var_path rt.PhpVal, manifest string) {
	mut var_manifest := manifest
	mut var_block_metadata_files := rt.new_null()
	mut var_block_metadata_file := rt.new_null()
	if var_manifest.len > 0 && var_manifest != '0' {
		wp_register_block_metadata_collection(var_path.clone(), rt.new_string(manifest))
	}
	mut iife_temp_0 := Class_WP_Block_Metadata_Registry{}
	mut iife_result_0 := iife_temp_0.get_collection_block_metadata_files(var_path.clone())
	var_block_metadata_files = iife_result_0
	mut iter_1 := var_block_metadata_files.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_metadata_file_shadow := item_1.val
		rt.new_bool(register_block_type_from_metadata(var_block_metadata_file_shadow.clone(),
			rt.new_null()))
	}
}

fn wp_register_block_metadata_collection(var_path rt.PhpVal, var_manifest rt.PhpVal) {
	mut iife_temp_1 := Class_WP_Block_Metadata_Registry{}
	mut iife_result_1 := iife_temp_1.register_collection(var_path.clone(), var_manifest.clone())
}

fn register_block_type_from_metadata(var_file_or_folder_arg rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_file_or_folder := var_file_or_folder_arg
	mut var_metadata_file := rt.new_null()
	mut var_is_core_block := rt.new_null()
	mut var_metadata_file_exists := false
	mut var_registry_metadata := rt.new_null()
	mut var_metadata := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_settings := rt.new_null()
	mut var_property_mappings := map[string]rt.PhpVal{}
	mut var_textdomain := rt.new_null()
	mut var_i18n_schema := rt.new_null()
	mut var_mapped_key := rt.new_null()
	mut var_key := rt.new_null()
	mut var_template_path := rt.new_null()
	mut var_variations_path := rt.new_null()
	mut var_script_fields := map[string]rt.PhpVal{}
	mut var_settings_field_name := rt.new_null()
	mut var_metadata_field_name := rt.new_null()
	mut var_scripts := rt.new_null()
	mut var_processed_scripts := []rt.PhpVal{}
	mut var_result := false
	mut var_index := i64(0)
	mut var_module_fields := map[string]rt.PhpVal{}
	mut var_modules := rt.new_null()
	mut var_processed_modules := []rt.PhpVal{}
	mut var_style_fields := map[string]rt.PhpVal{}
	mut var_styles := rt.new_null()
	mut var_processed_styles := []rt.PhpVal{}
	mut var_position_mappings := rt.new_null()
	mut var_position := rt.new_null()
	mut var_anchor_block_name := rt.new_null()
	var_file_or_folder = rt.call_function('wp_normalize_path', [
		var_file_or_folder.clone()])
	var_metadata_file = if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
		var_file_or_folder.clone(),
		rt.new_string('block.json'),
	])))))
	{
		(rt.call_function('trailingslashit', [var_file_or_folder.clone()])).str() + 'block.json'
	} else {
		var_file_or_folder
	}
	var_is_core_block = rt.call_function('str_starts_with', [
		var_file_or_folder.clone(),
		rt.call_function('wp_normalize_path', [
			rt.new_string((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str()),
		])])
	var_metadata_file_exists = rt.is_true(var_is_core_block)
		|| rt.is_true(rt.call_function('file_exists', [var_metadata_file.clone()]))
	mut iife_temp_2 := Class_WP_Block_Metadata_Registry{}
	mut iife_result_2 := iife_temp_2.get_metadata(var_file_or_folder.clone())
	var_registry_metadata = iife_result_2
	if rt.is_true(var_registry_metadata) {
		var_metadata = var_registry_metadata.clone()
	} else if var_metadata_file_exists {
		var_metadata = rt.call_function('wp_json_file_decode', [
			var_metadata_file.clone(), rt.create_array([
				rt.ArrayItem{ key: 'associative', val: true },
			])])
	} else {
		var_metadata = rt.new_array()
	}
	if !(var_metadata.clone().is_array())
		|| (!rt.is_true(var_metadata.array_get(rt.new_string('name')))
		&& !rt.is_true(var_args.array_get(rt.new_string('name')))) {
		return false
	}
	var_metadata.array_set('file', if var_metadata_file_exists { rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [var_metadata_file.clone()]),
		]) } else { rt.new_null() })
	var_metadata = rt.call_function('apply_filters', [
		rt.new_string('block_type_metadata'),
		var_metadata.clone(),
	])
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('name'))))
		&& rt.is_true(rt.call_function('str_starts_with', [var_metadata.array_get(rt.new_string('name')), rt.new_string('core/')])) {
		var_block_name = rt.call_function('str_replace', [rt.new_string('core/'),
			rt.new_string(''), var_metadata.array_get(rt.new_string('name'))])
		if !(var_metadata.array_isset(rt.new_string('style'))) {
			var_metadata.array_set('style', 'wp-block-${var_block_name.to_string()}')
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('wp-block-styles')]))
			&& rt.is_true(rt.call_function('wp_should_load_separate_core_block_assets', []rt.PhpVal{})) {
			var_metadata.array_set('style',
				rt.cast_array(var_metadata.array_get(rt.new_string('style'))))
			var_metadata.array_get_mut('style').array_push('wp-block-${var_block_name.to_string()}-theme')
		}
		if !(var_metadata.array_isset(rt.new_string('editorStyle'))) {
			var_metadata.array_set('editorStyle', 'wp-block-${var_block_name.to_string()}-editor')
		}
	}
	var_settings = rt.new_array()
	var_property_mappings = {
		'apiVersion':      'api_version'
		'name':            'name'
		'title':           'title'
		'category':        'category'
		'parent':          'parent'
		'ancestor':        'ancestor'
		'icon':            'icon'
		'description':     'description'
		'keywords':        'keywords'
		'attributes':      'attributes'
		'providesContext': 'provides_context'
		'usesContext':     'uses_context'
		'selectors':       'selectors'
		'supports':        'supports'
		'styles':          'styles'
		'variations':      'variations'
		'example':         'example'
		'allowedBlocks':   'allowed_blocks'
	}
	var_textdomain = if !(!rt.is_true(var_metadata.array_get(rt.new_string('textdomain')))) {
		var_metadata.array_get(rt.new_string('textdomain'))
	} else {
		rt.new_null()
	}
	var_i18n_schema = get_block_metadata_i18n_schema()
	for var_key_shadow, var_mapped_key_shadow in var_property_mappings {
		if var_metadata.array_isset(rt.new_string(var_key_shadow.str())) {
			var_settings.array_set(rt.new_string(var_mapped_key_shadow.str()),
				var_metadata.array_get(rt.new_string(var_key_shadow.str())))
			if var_metadata_file_exists && rt.is_true(var_textdomain)
				&& !(rt.get_property(var_i18n_schema, '{"nodeType":"Expr_Variable","line":544,"name":"key"}')).is_null() {
				var_settings.array_set(rt.new_string(var_mapped_key_shadow.str()), rt.call_function('translate_settings_using_i18n_schema', [
					rt.get_property(var_i18n_schema,
						'{"nodeType":"Expr_Variable","line":545,"name":"key"}'),
					var_settings.array_get(rt.new_string(var_key_shadow.str())),
					var_textdomain.clone(),
				]))
			}
		}
	}
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('render')))) {
		var_template_path = rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [
				rt.new_string(
					(rt.call_function('dirname', [var_metadata.array_get(rt.new_string('file'))])).str() +
					'/' +(remove_block_asset_path_prefix(var_metadata.array_get(rt.new_string('render')))).str()),
			]),
		])
		if rt.is_true(var_template_path) {
			closure_4_fn := fn [var_template_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_attributes := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut var_content := if args.len > 1 { args[1].clone() } else { rt.new_null() }
				mut var_block := if args.len > 2 { args[2].clone() } else { rt.new_null() }
				rt.call_function('ob_start', []rt.PhpVal{})
				rt.include_file(var_template_path.to_string(), '3')
				return (rt.call_function('ob_get_clean', []rt.PhpVal{})).to_bool()
			}
			var_settings.array_set('render_callback', rt.new_closure(closure_4_fn))
		}
	}
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('variations'))))
		&& var_metadata.array_get(rt.new_string('variations')).is_string() {
		var_variations_path = rt.call_function('wp_normalize_path', [
			rt.call_function('realpath', [
				rt.new_string(
					(rt.call_function('dirname', [var_metadata.array_get(rt.new_string('file'))])).str() +
					'/' +(remove_block_asset_path_prefix(var_metadata.array_get(rt.new_string('variations')))).str()),
			]),
		])
		if rt.is_true(var_variations_path) {
			closure_5_fn := fn [var_variations_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_variations := rt.include_file(var_variations_path.to_string(), '3')
				return var_variations.to_bool()
			}
			var_settings.array_set('variation_callback', rt.new_closure(closure_5_fn))
			var_settings.array_unset(rt.new_string('variations'))
		}
	}
	var_settings = rt.call_function('array_merge', [var_settings.clone(),
		rt.create_array_from_native_map(var_args)])
	var_script_fields = {
		'editorScript': 'editor_script_handles'
		'script':       'script_handles'
		'viewScript':   'view_script_handles'
	}
	for var_metadata_field_name_shadow, var_settings_field_name_shadow in var_script_fields {
		if !(!rt.is_true(var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_metadata.array_set(rt.new_string(var_metadata_field_name_shadow.str()),
				var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))
		}
		if !(!rt.is_true(var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_scripts =
				var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str()))
			var_processed_scripts = rt.new_array()
			if rt.is_true(rt.new_bool(var_scripts.clone().is_array())) {
				var_index = 0
				for {
					if !(var_index < var_scripts.clone().array_count()) { break
					 }
					var_result = register_block_script_handle(var_metadata.clone(),
						rt.new_string(var_metadata_field_name_shadow.str()).clone(), var_index)
					if var_result {
						var_processed_scripts << rt.new_bool(var_result).clone()
					}
					var_index += 1
				}
			} else {
				var_result = register_block_script_handle(var_metadata.clone(),
					rt.new_string(var_metadata_field_name_shadow.str()).clone())
				if var_result {
					var_processed_scripts << rt.new_bool(var_result).clone()
				}
			}
			var_settings.array_set(rt.new_string(var_settings_field_name_shadow.str()),
				var_processed_scripts.clone())
		}
	}
	var_module_fields = {
		'viewScriptModule': 'view_script_module_ids'
	}
	for var_metadata_field_name_shadow, var_settings_field_name_shadow in var_module_fields {
		if !(!rt.is_true(var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_metadata.array_set(rt.new_string(var_metadata_field_name_shadow.str()),
				var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))
		}
		if !(!rt.is_true(var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_modules =
				var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str()))
			var_processed_modules = rt.new_array()
			if rt.is_true(rt.new_bool(var_modules.clone().is_array())) {
				var_index = 0
				for {
					if !(var_index < var_modules.clone().array_count()) { break
					 }
					var_result = register_block_script_module_id(var_metadata.clone(),
						rt.new_string(var_metadata_field_name_shadow.str()).clone(), var_index)
					if var_result {
						var_processed_modules << rt.new_bool(var_result).clone()
					}
					var_index += 1
				}
			} else {
				var_result = register_block_script_module_id(var_metadata.clone(),
					rt.new_string(var_metadata_field_name_shadow.str()).clone())
				if var_result {
					var_processed_modules << rt.new_bool(var_result).clone()
				}
			}
			var_settings.array_set(rt.new_string(var_settings_field_name_shadow.str()),
				var_processed_modules.clone())
		}
	}
	var_style_fields = {
		'editorStyle': 'editor_style_handles'
		'style':       'style_handles'
		'viewStyle':   'view_style_handles'
	}
	for var_metadata_field_name_shadow, var_settings_field_name_shadow in var_style_fields {
		if !(!rt.is_true(var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_metadata.array_set(rt.new_string(var_metadata_field_name_shadow.str()),
				var_settings.array_get(rt.new_string(var_metadata_field_name_shadow.str())))
		}
		if !(!rt.is_true(var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str())))) {
			var_styles = var_metadata.array_get(rt.new_string(var_metadata_field_name_shadow.str()))
			var_processed_styles = rt.new_array()
			if rt.is_true(rt.new_bool(var_styles.clone().is_array())) {
				var_index = 0
				for {
					if !(var_index < var_styles.clone().array_count()) { break
					 }
					var_result = register_block_style_handle(var_metadata.clone(),
						rt.new_string(var_metadata_field_name_shadow.str()).clone(), var_index)
					if var_result {
						var_processed_styles << rt.new_bool(var_result).clone()
					}
					var_index += 1
				}
			} else {
				var_result = register_block_style_handle(var_metadata.clone(),
					rt.new_string(var_metadata_field_name_shadow.str()).clone())
				if var_result {
					var_processed_styles << rt.new_bool(var_result).clone()
				}
			}
			var_settings.array_set(rt.new_string(var_settings_field_name_shadow.str()),
				var_processed_styles.clone())
		}
	}
	if !(!rt.is_true(var_metadata.array_get(rt.new_string('blockHooks')))) {
		var_position_mappings = rt.create_array([
			rt.ArrayItem{ key: 'before', val: 'before' },
			rt.ArrayItem{ key: 'after', val: 'after' },
			rt.ArrayItem{ key: 'firstChild', val: 'first_child' },
			rt.ArrayItem{ key: 'lastChild', val: 'last_child' },
		])
		var_settings.array_set('block_hooks', rt.new_array())
		mut iter_2 := var_metadata.array_get(rt.new_string('blockHooks')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_position_shadow := item_2.val
			mut var_anchor_block_name_shadow := item_2.key
			if rt.is_true(rt.identical(var_metadata.array_get(rt.new_string('name')),
				var_anchor_block_name_shadow))
			{
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
					rt.call_function('__', [
						rt.new_string('Cannot hook block to itself.'),
					]),
					rt.new_string('6.4.0')])
				continue
			}
			if !(var_position_mappings.array_isset(var_position_shadow)) {
				continue
			}
			var_settings.array_get_mut('block_hooks').array_set(var_anchor_block_name_shadow,
				var_position_mappings.array_get(var_position_shadow))
		}
	}
	var_settings = rt.call_function('apply_filters', [
		rt.new_string('block_type_metadata_settings'),
		var_settings.clone(),
		var_metadata.clone(),
	])
	var_metadata.array_set('name', if !(!rt.is_true(var_settings.array_get(rt.new_string('name')))) {
		var_settings.array_get(rt.new_string('name'))
	} else {
		var_metadata.array_get(rt.new_string('name'))
	})
	mut iife_temp_5 := Class_WP_Block_Type_Registry{}
	mut iife_result_5 := iife_temp_5.get_instance()
	return (rt.call_method(iife_result_5, 'register', [
		var_metadata.array_get(rt.new_string('name')),
		var_settings.clone(),
	])).to_bool()
}

fn register_block_type(var_block_type rt.PhpVal, var_args rt.PhpVal) bool {
	if var_block_type.clone().is_string()
		&& rt.is_true(rt.call_function('file_exists', [var_block_type.clone()])) {
		return register_block_type_from_metadata(var_block_type.clone(),
			rt.create_array_from_native_map(var_args))
	}
	mut iife_temp_6 := Class_WP_Block_Type_Registry{}
	mut iife_result_6 := iife_temp_6.get_instance()
	return (rt.call_method(iife_result_6, 'register', [var_block_type.clone(),
		rt.create_array_from_native_map(var_args)])).to_bool()
}

fn unregister_block_type(var_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_7 := Class_WP_Block_Type_Registry{}
	mut iife_result_7 := iife_temp_7.get_instance()
	return rt.call_method(iife_result_7, 'unregister', [var_name.clone()])
}

fn has_blocks(var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_wp_post := rt.new_null()
	if !(var_post.clone().is_string()) {
		var_wp_post = rt.call_function('get_post', [var_post.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_wp_post, 'WP_Post')))))) {
			return false
		}
		var_post = rt.get_property(var_wp_post, 'post_content')
	}
	return (rt.call_function('str_contains', [rt.new_string(var_post.str()),
		rt.new_string('<!-- wp:')])).to_bool()
}

fn has_block(var_block_name_arg rt.PhpVal, var_post_arg rt.PhpVal) bool {
	mut var_block_name := var_block_name_arg
	mut var_post := var_post_arg
	mut var_wp_post := rt.new_null()
	mut var_has_block := rt.new_null()
	mut var_serialized_block_name := rt.new_null()
	if !(has_blocks(var_post.clone())) {
		return false
	}
	if !(var_post.clone().is_string()) {
		var_wp_post = rt.call_function('get_post', [var_post.clone()])
		if rt.is_true(rt.new_bool(rt.instance_of(var_wp_post, 'WP_Post'))) {
			var_post = rt.get_property(var_wp_post, 'post_content')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_block_name.clone(), rt.new_string('/')])))))
	{
		var_block_name = rt.new_string('core/' + var_block_name.str())
	}
	var_has_block = rt.call_function('str_contains', [var_post.clone(),
		rt.new_string('<!-- wp:' + var_block_name.str() + ' ')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_block)))) {
		var_serialized_block_name = strip_core_block_namespace(var_block_name.clone())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_serialized_block_name,
			var_block_name))))
		{
			var_has_block = rt.call_function('str_contains', [
				var_post.clone(), rt.new_string('<!-- wp:' + var_serialized_block_name.str() + ' ')])
		}
	}
	return var_has_block.to_bool()
}

fn get_dynamic_block_names() rt.PhpVal {
	mut var_dynamic_block_names := []rt.PhpVal{}
	mut var_block_types := rt.new_null()
	mut var_block_type := rt.new_null()
	var_dynamic_block_names = rt.new_array()
	mut iife_temp_8 := Class_WP_Block_Type_Registry{}
	mut iife_result_8 := iife_temp_8.get_instance()
	var_block_types = rt.call_method(iife_result_8, 'get_all_registered', []rt.PhpVal{})
	mut iter_3 := var_block_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_block_type_shadow := item_3.val
		if rt.is_true(rt.call_method(var_block_type_shadow, 'is_dynamic', []rt.PhpVal{})) {
			var_dynamic_block_names << rt.get_property(var_block_type_shadow, 'name')
		}
	}
	return var_dynamic_block_names.clone()
}

fn get_hooked_blocks() rt.PhpVal {
	mut var_block_types := rt.new_null()
	mut var_hooked_blocks := rt.new_null()
	mut var_block_type := rt.new_null()
	mut var_relative_position := rt.new_null()
	mut var_anchor_block_type := rt.new_null()
	mut iife_temp_9 := Class_WP_Block_Type_Registry{}
	mut iife_result_9 := iife_temp_9.get_instance()
	var_block_types = rt.call_method(iife_result_9, 'get_all_registered', []rt.PhpVal{})
	var_hooked_blocks = rt.new_array()
	mut iter_4 := var_block_types.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_block_type_shadow := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_block_type_shadow, 'WP_Block_Type'))))))
			|| !(rt.get_property(var_block_type_shadow, 'block_hooks').is_array()) {
			continue
		}
		mut iter_5 := rt.get_property(var_block_type_shadow, 'block_hooks').iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_relative_position_shadow := item_5.val
			mut var_anchor_block_type_shadow := item_5.key
			if !(var_hooked_blocks.array_isset(var_anchor_block_type_shadow)) {
				var_hooked_blocks.array_set(var_anchor_block_type_shadow, rt.new_array())
			}
			if !(var_hooked_blocks.array_get(var_anchor_block_type_shadow).array_isset(var_relative_position_shadow)) {
				var_hooked_blocks.array_get_mut(var_anchor_block_type_shadow).array_set(var_relative_position_shadow,
					rt.new_array())
			}
			var_hooked_blocks.array_get_mut(var_anchor_block_type_shadow).array_get_mut(var_relative_position_shadow).array_push(rt.get_property(var_block_type_shadow,
				'name'))
		}
	}
	return var_hooked_blocks.clone()
}

fn insert_hooked_blocks(var_parsed_anchor_block rt.PhpVal, var_relative_position rt.PhpVal, var_hooked_blocks rt.PhpVal, var_context rt.PhpVal) string {
	mut var_anchor_block_type := rt.new_null()
	mut var_hooked_block_types := rt.new_null()
	mut var_markup := ''
	mut var_hooked_block_type := rt.new_null()
	mut var_parsed_hooked_block := rt.new_null()
	var_anchor_block_type = var_parsed_anchor_block.array_get(rt.new_string('blockName'))
	var_hooked_block_types = if !var_anchor_block_type.is_null()
		&& var_hooked_blocks.array_get(var_anchor_block_type).array_isset(var_relative_position) {
		var_hooked_blocks.array_get(var_anchor_block_type).array_get(var_relative_position)
	} else {
		rt.new_array()
	}
	var_hooked_block_types = rt.call_function('apply_filters', [
		rt.new_string('hooked_block_types'),
		var_hooked_block_types.clone(),
		var_relative_position.clone(),
		var_anchor_block_type.clone(),
		var_context.clone(),
	])
	var_markup = ''
	mut iter_6 := var_hooked_block_types.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_hooked_block_type_shadow := item_6.val
		var_parsed_hooked_block = rt.create_array([
			rt.ArrayItem{ key: 'blockName', val: var_hooked_block_type_shadow },
			rt.ArrayItem{ key: 'attrs', val: rt.new_array() },
			rt.ArrayItem{ key: 'innerBlocks', val: rt.new_array() },
			rt.ArrayItem{ key: 'innerHTML', val: '' },
			rt.ArrayItem{ key: 'innerContent', val: rt.new_array() },
		])
		var_parsed_hooked_block = rt.call_function('apply_filters', [
			rt.new_string('hooked_block'),
			var_parsed_hooked_block.clone(),
			var_hooked_block_type_shadow.clone(),
			var_relative_position.clone(),
			rt.create_array_from_native_map(var_parsed_anchor_block),
			var_context.clone(),
		])
		var_parsed_hooked_block = rt.call_function('apply_filters', [
			rt.new_string('hooked_block_${var_hooked_block_type.to_string()}'),
			var_parsed_hooked_block.clone(),
			var_hooked_block_type_shadow.clone(),
			var_relative_position.clone(),
			rt.create_array_from_native_map(var_parsed_anchor_block),
			var_context.clone(),
		])
		if rt.is_true(rt.identical(rt.new_null(), var_parsed_hooked_block)) {
			continue
		}
		if !(var_parsed_anchor_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_isset(rt.new_string('ignoredHookedBlocks')))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_hooked_block_type_shadow.clone(), var_parsed_anchor_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks')), rt.new_bool(true)]))))) {
			var_markup = var_markup + (serialize_block(var_parsed_hooked_block.clone())).str()
		}
	}
	return var_markup
}

fn set_ignored_hooked_blocks_metadata(var_parsed_anchor_block rt.PhpVal, var_relative_position rt.PhpVal, var_hooked_blocks rt.PhpVal, var_context rt.PhpVal) string {
	mut var_anchor_block_type := rt.new_null()
	mut var_hooked_block_types := rt.new_null()
	mut var_hooked_block_type := rt.new_null()
	mut var_index := rt.new_null()
	mut var_parsed_hooked_block := rt.new_null()
	mut var_previously_ignored_hooked_blocks := rt.new_null()
	var_anchor_block_type = var_parsed_anchor_block.array_get(rt.new_string('blockName'))
	var_hooked_block_types = if !var_anchor_block_type.is_null()
		&& var_hooked_blocks.array_get(var_anchor_block_type).array_isset(var_relative_position) {
		var_hooked_blocks.array_get(var_anchor_block_type).array_get(var_relative_position)
	} else {
		rt.new_array()
	}
	var_hooked_block_types = rt.call_function('apply_filters', [
		rt.new_string('hooked_block_types'),
		var_hooked_block_types.clone(),
		var_relative_position.clone(),
		var_anchor_block_type.clone(),
		var_context.clone(),
	])
	if !rt.is_true(var_hooked_block_types) {
		return ''
	}
	mut iter_7 := var_hooked_block_types.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_hooked_block_type_shadow := item_7.val
		mut var_index_shadow := item_7.key
		var_parsed_hooked_block = rt.create_array([
			rt.ArrayItem{ key: 'blockName', val: var_hooked_block_type_shadow },
			rt.ArrayItem{ key: 'attrs', val: rt.new_array() },
			rt.ArrayItem{ key: 'innerBlocks', val: rt.new_array() },
			rt.ArrayItem{ key: 'innerContent', val: rt.new_array() },
		])
		var_parsed_hooked_block = rt.call_function('apply_filters', [
			rt.new_string('hooked_block'),
			var_parsed_hooked_block.clone(),
			var_hooked_block_type_shadow.clone(),
			var_relative_position.clone(),
			rt.create_array_from_native_map(var_parsed_anchor_block),
			var_context.clone(),
		])
		var_parsed_hooked_block = rt.call_function('apply_filters', [
			rt.new_string('hooked_block_${var_hooked_block_type.to_string()}'),
			var_parsed_hooked_block.clone(),
			var_hooked_block_type_shadow.clone(),
			var_relative_position.clone(),
			rt.create_array_from_native_map(var_parsed_anchor_block),
			var_context.clone(),
		])
		if rt.is_true(rt.identical(rt.new_null(), var_parsed_hooked_block)) {
			var_hooked_block_types.array_unset(var_index_shadow)
		}
	}
	var_previously_ignored_hooked_blocks = if !(var_parsed_anchor_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks'))).is_null() {
		var_parsed_anchor_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks'))
	} else {
		rt.new_array()
	}
	var_parsed_anchor_block.array_get_mut('attrs').array_get_mut('metadata').array_set('ignoredHookedBlocks', rt.call_function('array_unique', [
		rt.call_function('array_merge', [var_previously_ignored_hooked_blocks.clone(),
			var_hooked_block_types.clone()]),
	]))
	return ''
}

fn apply_block_hooks_to_content(var_content_arg rt.PhpVal, var_context_arg rt.PhpVal, callback string) rt.PhpVal {
	mut var_callback := callback
	mut var_content := var_content_arg
	mut var_context := var_context_arg
	mut var_hooked_blocks := rt.new_null()
	mut var_before_block_visitor := rt.new_null()
	mut var_after_block_visitor := rt.new_null()
	mut var_block_allows_multiple_instances := rt.new_null()
	mut var_relative_positions := rt.new_null()
	mut var_anchor_block_type := rt.new_null()
	mut var_hooked_block_types := rt.new_null()
	mut var_relative_position := rt.new_null()
	mut var_hooked_block_type := rt.new_null()
	mut var_index := rt.new_null()
	mut var_hooked_block_type_definition := rt.new_null()
	mut var_suppress_single_instance_blocks := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_context)) {
		var_context = rt.call_function('get_post', []rt.PhpVal{})
	}
	var_hooked_blocks = get_hooked_blocks()
	var_before_block_visitor = rt.new_string('_inject_theme_attribute_in_template_part_block')
	var_after_block_visitor = rt.new_null()
	if !(!rt.is_true(var_hooked_blocks))
		|| rt.is_true(rt.call_function('has_filter', [rt.new_string('hooked_block_types')])) {
		var_before_block_visitor = make_before_block_visitor(var_hooked_blocks.clone(),
			var_context.clone(), callback)
		var_after_block_visitor = make_after_block_visitor(var_hooked_blocks.clone(),
			var_context.clone(), callback)
	}
	var_block_allows_multiple_instances = rt.new_array()
	mut iter_8 := var_hooked_blocks.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_relative_positions_shadow := item_8.val
		mut var_anchor_block_type_shadow := item_8.key
		mut iter_9 := var_relative_positions_shadow.iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_hooked_block_types_shadow := item_9.val
			mut var_relative_position_shadow := item_9.key
			mut iter_10 := var_hooked_block_types_shadow.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_hooked_block_type_shadow := item_10.val
				mut var_index_shadow := item_10.key
				mut iife_temp_10 := Class_WP_Block_Type_Registry{}
				mut iife_result_10 := iife_temp_10.get_instance()
				var_hooked_block_type_definition = rt.call_method(iife_result_10, 'get_registered', [
					var_hooked_block_type_shadow.clone(),
				])
				var_block_allows_multiple_instances.array_set(var_hooked_block_type_shadow, block_has_support(var_hooked_block_type_definition.clone(),
					'multiple', true))
				if rt.is_true(rt.new_bool(!(rt.is_true(var_block_allows_multiple_instances.array_get(var_hooked_block_type_shadow)))))
					&& has_block(var_hooked_block_type_shadow.clone(), var_content.clone()) {
					var_hooked_blocks.array_get(var_anchor_block_type_shadow).array_get(var_relative_position_shadow).array_unset(var_index_shadow)
				}
			}
			if !rt.is_true(var_hooked_blocks.array_get(var_anchor_block_type_shadow).array_get(var_relative_position_shadow)) {
				var_hooked_blocks.array_get(var_anchor_block_type_shadow).array_unset(var_relative_position_shadow)
			}
		}
		if !rt.is_true(var_hooked_blocks.array_get(var_anchor_block_type_shadow)) {
			var_hooked_blocks.array_unset(var_anchor_block_type_shadow)
		}
	}
	closure_13_fn := fn [mut var_block_allows_multiple_instances, var_content] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_hooked_block_types := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_single_instance_blocks_present_in_content := rt.new_null()
		mut iter_11 := var_hooked_block_types.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_hooked_block_type := item_11.val
			mut var_index := item_11.key
			if !(var_block_allows_multiple_instances.array_isset(var_hooked_block_type)) {
				mut iife_temp_12 := Class_WP_Block_Type_Registry{}
				mut iife_result_12 := iife_temp_12.get_instance()
				mut var_hooked_block_type_definition := rt.call_method(iife_result_12,
					'get_registered', [var_hooked_block_type.clone()])
				var_block_allows_multiple_instances.array_set(var_hooked_block_type, block_has_support(var_hooked_block_type_definition.clone(),
					'multiple', true))
			}
			if rt.is_true(var_block_allows_multiple_instances.array_get(var_hooked_block_type)) {
				continue
			}
			if rt.is_true(rt.call_function('in_array', [var_hooked_block_type.clone(), var_single_instance_blocks_present_in_content.clone(), rt.new_bool(true)]))
				|| has_block(var_hooked_block_type.clone(), var_content.clone()) {
				var_hooked_block_types.array_unset(var_index)
			} else {
				var_single_instance_blocks_present_in_content.array_push(var_hooked_block_type.clone())
			}
		}
		return var_hooked_block_types.clone()
	}
	var_suppress_single_instance_blocks = rt.new_closure(closure_13_fn)
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
		var_suppress_single_instance_blocks.clone(), rt.get_constant('PHP_INT_MAX')])
	var_content = rt.new_string(traverse_and_serialize_blocks(parse_blocks(var_content.clone()),
		var_before_block_visitor.clone(), var_after_block_visitor.clone()))
	rt.call_function('remove_filter', [rt.new_string('hooked_block_types'),
		var_suppress_single_instance_blocks.clone(), rt.get_constant('PHP_INT_MAX')])
	return var_content.clone()
}

fn apply_block_hooks_to_content_from_post_object(var_content_arg rt.PhpVal, var_post_arg rt.PhpVal, callback string, var_ignored_hooked_blocks_at_root_arg rt.PhpVal) rt.PhpVal {
	mut var_callback := callback
	mut var_content := var_content_arg
	mut var_post := var_post_arg
	mut var_ignored_hooked_blocks_at_root := var_ignored_hooked_blocks_at_root_arg
	mut var_original_content := rt.new_null()
	mut var_content_wrapped_in_classic_block := rt.new_null()
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_ignored_hooked_blocks := rt.new_null()
	mut var_wrapper_block_type := ''
	mut var_suppress_blocks_from_insertion_before_and_after_wrapper_block := rt.new_null()
	mut var_wrapper_block_markup := rt.new_null()
	mut var_wrapper_block := rt.new_null()
	if rt.is_true(rt.identical(rt.new_null(), var_post)) {
		var_post = rt.call_function('get_post', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return apply_block_hooks_to_content(var_content.clone(), var_post.clone(), callback)
	}
	if !(has_blocks(var_content.clone())) {
		var_original_content = var_content.clone()
		var_content_wrapped_in_classic_block = get_comment_delimited_block_content(rt.new_string('core/freeform'),
			rt.new_array(), var_content.clone())
		var_content = var_content_wrapped_in_classic_block.clone()
	}
	var_attributes = rt.new_array()
	var_ignored_hooked_blocks = rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_wp_ignored_hooked_blocks'),
		rt.new_bool(true),
	])
	if !(!rt.is_true(var_ignored_hooked_blocks)) {
		var_ignored_hooked_blocks = rt.call_function('json_decode', [
			var_ignored_hooked_blocks.clone(), rt.new_bool(true)])
		var_attributes['metadata'] = rt.create_array([
			rt.ArrayItem{ key: 'ignoredHookedBlocks', val: var_ignored_hooked_blocks },
		])
	}
	if rt.is_true(rt.identical(rt.new_string('wp_navigation'), rt.get_property(var_post,
		'post_type')))
	{
		var_wrapper_block_type = 'core/navigation'
	} else if rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_property(var_post,
		'post_type')))
	{
		var_wrapper_block_type = 'core/block'
	} else {
		var_wrapper_block_type = 'core/post-content'
	}
	var_content = get_comment_delimited_block_content(rt.new_string(var_wrapper_block_type.str()).clone(),
		rt.create_array_from_native_map(var_attributes), var_content.clone())
	closure_14_fn := fn [var_wrapper_block_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_hooked_block_types := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_relative_position := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_anchor_block_type := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		if rt.is_true(rt.identical(rt.new_string(var_wrapper_block_type.str()), var_anchor_block_type))
			&& rt.is_true(rt.call_function('in_array', [var_relative_position.clone(), rt.create_array([rt.ArrayItem{
			key: none
			val: 'before'
		}, rt.ArrayItem{ key: none, val: 'after' }]), rt.new_bool(true)])) {
			return rt.new_array()
		}
		return var_hooked_block_types.clone()
	}
	var_suppress_blocks_from_insertion_before_and_after_wrapper_block =
		rt.new_closure(closure_14_fn)
	rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
		var_suppress_blocks_from_insertion_before_and_after_wrapper_block.clone(),
		rt.get_constant('PHP_INT_MAX'), rt.new_int(3)])
	var_content = apply_block_hooks_to_content(var_content.clone(), var_post.clone(), callback)
	rt.call_function('remove_filter', [rt.new_string('hooked_block_types'),
		var_suppress_blocks_from_insertion_before_and_after_wrapper_block.clone(),
		rt.get_constant('PHP_INT_MAX')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		var_ignored_hooked_blocks_at_root))))
	{
		var_wrapper_block_markup =
			rt.new_string(extract_serialized_parent_block(var_content.clone()))
		var_wrapper_block = parse_blocks(var_wrapper_block_markup.clone()).array_get(rt.new_int(0))
		if !(!rt.is_true(var_wrapper_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks')))) {
			var_ignored_hooked_blocks_at_root =
				var_wrapper_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks'))
		}
	}
	var_content = remove_serialized_parent_block(var_content.clone())
	if !(!rt.is_true(var_content_wrapped_in_classic_block)) {
		var_content = rt.call_function('str_replace', [var_content_wrapped_in_classic_block.clone(),
			var_original_content.clone(), var_content.clone()])
	}
	return var_content.clone()
}

fn remove_serialized_parent_block(var_serialized_block rt.PhpVal) rt.PhpVal {
	mut var_start := rt.new_null()
	mut var_end := rt.new_null()
	var_start = rt.add(rt.call_function('strpos', [var_serialized_block.clone(),
		rt.new_string('-->')]), rt.new_int('-->'.len))
	var_end = rt.call_function('strrpos', [var_serialized_block.clone(),
		rt.new_string('<!--')])
	return rt.call_function('substr', [var_serialized_block.clone(),
		var_start.clone(), rt.sub(var_end, var_start)])
}

fn extract_serialized_parent_block(var_serialized_block rt.PhpVal) string {
	mut var_start := rt.new_null()
	mut var_end := rt.new_null()
	var_start = rt.add(rt.call_function('strpos', [var_serialized_block.clone(),
		rt.new_string('-->')]), rt.new_int('-->'.len))
	var_end = rt.call_function('strrpos', [var_serialized_block.clone(),
		rt.new_string('<!--')])
	return
		(rt.call_function('substr', [var_serialized_block.clone(), rt.new_int(0), var_start.clone()])).str() +
		(rt.call_function('substr', [var_serialized_block.clone(), var_end.clone()])).str()
}

fn update_ignored_hooked_blocks_postmeta(var_post rt.PhpVal) rt.PhpVal {
	mut var_attributes := map[string]rt.PhpVal{}
	mut var_ignored_hooked_blocks := rt.new_null()
	mut var_wrapper_block_type := ''
	mut var_markup := rt.new_null()
	mut var_existing_post := rt.new_null()
	mut var_context := rt.new_null()
	mut var_serialized_block := rt.new_null()
	mut var_root_block := rt.new_null()
	mut var_existing_ignored_hooked_blocks := rt.new_null()
	if !rt.is_true(rt.get_property(var_post, 'ID')) {
		return var_post.clone()
	}
	if !(!(rt.get_property(var_post, 'post_content')).is_null()) {
		return var_post.clone()
	}
	if !(!(rt.get_property(var_post, 'post_type')).is_null()) {
		return var_post.clone()
	}
	var_attributes = rt.new_array()
	var_ignored_hooked_blocks = rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_wp_ignored_hooked_blocks'),
		rt.new_bool(true),
	])
	if !(!rt.is_true(var_ignored_hooked_blocks)) {
		var_ignored_hooked_blocks = rt.call_function('json_decode', [
			var_ignored_hooked_blocks.clone(), rt.new_bool(true)])
		var_attributes['metadata'] = rt.create_array([
			rt.ArrayItem{ key: 'ignoredHookedBlocks', val: var_ignored_hooked_blocks },
		])
	}
	if rt.is_true(rt.identical(rt.new_string('wp_navigation'), rt.get_property(var_post,
		'post_type')))
	{
		var_wrapper_block_type = 'core/navigation'
	} else if rt.is_true(rt.identical(rt.new_string('wp_block'), rt.get_property(var_post,
		'post_type')))
	{
		var_wrapper_block_type = 'core/block'
	} else {
		var_wrapper_block_type = 'core/post-content'
	}
	var_markup = get_comment_delimited_block_content(rt.new_string(var_wrapper_block_type.str()).clone(),
		rt.create_array_from_native_map(var_attributes), rt.get_property(var_post, 'post_content'))
	var_existing_post = rt.call_function('get_post', [rt.get_property(var_post, 'ID')])
	var_context = rt.array_to_object(rt.call_function('array_merge', [
		rt.cast_array(var_existing_post),
		rt.cast_array(var_post),
	]))
	var_context = create_wp_post(var_context.clone())
	var_serialized_block = apply_block_hooks_to_content(var_markup.clone(), var_context.clone(),
		'set_ignored_hooked_blocks_metadata')
	var_root_block = parse_blocks(var_serialized_block.clone()).array_get(rt.new_int(0))
	var_ignored_hooked_blocks = if !(var_root_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks'))).is_null() {
		var_root_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('ignoredHookedBlocks'))
	} else {
		rt.new_array()
	}
	if !(!rt.is_true(var_ignored_hooked_blocks)) {
		var_existing_ignored_hooked_blocks = rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('_wp_ignored_hooked_blocks'),
			rt.new_bool(true),
		])
		if !(!rt.is_true(var_existing_ignored_hooked_blocks)) {
			var_existing_ignored_hooked_blocks = rt.call_function('json_decode', [
				var_existing_ignored_hooked_blocks.clone(),
				rt.new_bool(true),
			])
			var_ignored_hooked_blocks = rt.call_function('array_unique', [
				rt.call_function('array_merge', [var_ignored_hooked_blocks.clone(),
					var_existing_ignored_hooked_blocks.clone()]),
			])
		}
		if !(!(rt.get_property(var_post, 'meta_input')).is_null()) {
			rt.set_property(var_post, 'meta_input', rt.new_array())
		}
		rt.get_property(var_post, 'meta_input').array_set('_wp_ignored_hooked_blocks',
			rt.json_encode(var_ignored_hooked_blocks.clone()))
	}
	rt.set_property(var_post, 'post_content',
		remove_serialized_parent_block(var_serialized_block.clone()))
	return var_post.clone()
}

fn insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata(var_parsed_anchor_block rt.PhpVal, var_relative_position rt.PhpVal, var_hooked_blocks rt.PhpVal, var_context rt.PhpVal) string {
	mut var_markup := ''
	var_markup = insert_hooked_blocks(rt.create_array_from_native_map(var_parsed_anchor_block),
		var_relative_position.clone(), var_hooked_blocks.clone(), var_context.clone())
	var_markup = var_markup +
		set_ignored_hooked_blocks_metadata(rt.create_array_from_native_map(var_parsed_anchor_block), var_relative_position.clone(), var_hooked_blocks.clone(), var_context.clone())
	return var_markup
}

fn insert_hooked_blocks_into_rest_response(var_response rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_ignored_hooked_blocks_at_root := rt.new_null()
	mut var_priority := rt.new_null()
	if !rt.is_true(rt.get_property(var_response, 'data').array_get(rt.new_string('content')).array_get(rt.new_string('raw'))) {
		return var_response.clone()
	}
	var_ignored_hooked_blocks_at_root = rt.new_array()
	rt.get_property(var_response, 'data').array_get_mut('content').array_set('raw', apply_block_hooks_to_content_from_post_object(rt.get_property(var_response,
		'data').array_get(rt.new_string('content')).array_get(rt.new_string('raw')),
		var_post.clone(), 'insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata',
		var_ignored_hooked_blocks_at_root.clone()))
	if !(!rt.is_true(var_ignored_hooked_blocks_at_root)) {
		rt.get_property(var_response, 'data').array_get_mut('meta').array_set('_wp_ignored_hooked_blocks', rt.call_function('wp_json_encode', [
			var_ignored_hooked_blocks_at_root.clone(),
		]))
	}
	if !rt.is_true(rt.get_property(var_response, 'data').array_get(rt.new_string('content')).array_get(rt.new_string('rendered'))) {
		return var_response.clone()
	}
	var_priority = rt.call_function('has_filter', [rt.new_string('the_content'),
		rt.new_string('apply_block_hooks_to_content_from_post_object')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_priority)))) {
		rt.call_function('remove_filter', [rt.new_string('the_content'),
			rt.new_string('apply_block_hooks_to_content_from_post_object'),
			var_priority.clone()])
	}
	rt.get_property(var_response, 'data').array_get_mut('content').array_set('rendered', rt.call_function('apply_filters', [
		rt.new_string('the_content'),
		rt.get_property(var_response, 'data').array_get(rt.new_string('content')).array_get(rt.new_string('raw')),
	]))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_priority)))) {
		rt.call_function('add_filter', [rt.new_string('the_content'),
			rt.new_string('apply_block_hooks_to_content_from_post_object'),
			var_priority.clone()])
	}
	return var_response.clone()
}

fn make_before_block_visitor(var_hooked_blocks rt.PhpVal, var_context rt.PhpVal, callback string) rt.PhpVal {
	mut var_callback := callback
	closure_15_fn := fn [var_hooked_blocks, var_context, var_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parent_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_prev := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		rt.call_function('_inject_theme_attribute_in_template_part_block', [
			var_block.clone()])
		mut var_markup := rt.new_string('')
		if rt.is_true(var_parent_block) && rt.is_true(rt.new_bool(!(rt.is_true(var_prev)))) {
			var_markup = rt.concat(var_markup, rt.call_function('call_user_func_array', [
				rt.new_string(callback),
				rt.create_array([rt.ArrayItem{ key: none, val: var_parent_block },
					rt.ArrayItem{ key: none, val: 'first_child' },
					rt.ArrayItem{ key: none, val: var_hooked_blocks },
					rt.ArrayItem{ key: none, val: var_context }]),
			]))
		}
		var_markup = rt.concat(var_markup, rt.call_function('call_user_func_array', [
			rt.new_string(callback),
			rt.create_array([rt.ArrayItem{ key: none, val: var_block },
				rt.ArrayItem{ key: none, val: 'before' }, rt.ArrayItem{
					key: none
					val: var_hooked_blocks
				}, rt.ArrayItem{ key: none, val: var_context }]),
		]))
		return var_markup.clone()
	}
	return rt.new_closure(closure_15_fn)
}

fn make_after_block_visitor(var_hooked_blocks rt.PhpVal, var_context rt.PhpVal, callback string) rt.PhpVal {
	mut var_callback := callback
	closure_16_fn := fn [var_hooked_blocks, var_context, var_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_block := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parent_block := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_next := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_markup := rt.call_function('call_user_func_array', [
			rt.new_string(callback),
			rt.create_array([rt.ArrayItem{ key: none, val: var_block },
				rt.ArrayItem{ key: none, val: 'after' }, rt.ArrayItem{
					key: none
					val: var_hooked_blocks
				}, rt.ArrayItem{ key: none, val: var_context }]),
		])
		if rt.is_true(var_parent_block) && rt.is_true(rt.new_bool(!(rt.is_true(var_next)))) {
			var_markup = rt.concat(var_markup, rt.call_function('call_user_func_array', [
				rt.new_string(callback),
				rt.create_array([rt.ArrayItem{ key: none, val: var_parent_block },
					rt.ArrayItem{ key: none, val: 'last_child' },
					rt.ArrayItem{ key: none, val: var_hooked_blocks },
					rt.ArrayItem{ key: none, val: var_context }]),
			]))
		}
		return var_markup.clone()
	}
	return rt.new_closure(closure_16_fn)
}

fn serialize_block_attributes(var_block_attributes rt.PhpVal) rt.PhpVal {
	mut var_encoded_attributes := rt.new_null()
	var_encoded_attributes = rt.call_function('wp_json_encode', [
		var_block_attributes.clone(),
		rt.bitwise_or(rt.get_constant('JSON_UNESCAPED_SLASHES'),
			rt.get_constant('JSON_UNESCAPED_UNICODE'))])
	return rt.call_function('strtr', [var_encoded_attributes.clone(),
		rt.create_array([rt.ArrayItem{ key: '\\\\', val: '\\u005c' },
			rt.ArrayItem{ key: '--', val: '\\u002d\\u002d' },
			rt.ArrayItem{ key: '<', val: '\\u003c' }, rt.ArrayItem{ key: '>', val: '\\u003e' },
			rt.ArrayItem{ key: '&', val: '\\u0026' }, rt.ArrayItem{ key: '\\"', val: '\\u0022' }])])
}

fn strip_core_block_namespace(var_block_name rt.PhpVal) rt.PhpVal {
	if var_block_name.clone().is_string()
		&& rt.is_true(rt.call_function('str_starts_with', [var_block_name.clone(), rt.new_string('core/')])) {
		return rt.call_function('substr', [var_block_name.clone(),
			rt.new_int(5)])
	}
	return var_block_name.clone()
}

fn get_comment_delimited_block_content(var_block_name rt.PhpVal, var_block_attributes rt.PhpVal, var_block_content rt.PhpVal) rt.PhpVal {
	mut var_serialized_block_name := rt.new_null()
	mut var_serialized_attributes := rt.new_null()
	if rt.is_true(rt.new_bool(var_block_name.clone().is_null())) {
		return var_block_content.clone()
	}
	var_serialized_block_name = strip_core_block_namespace(var_block_name.clone())
	var_serialized_attributes = rt.new_string((if !rt.is_true(var_block_attributes) {
		''
	} else {
		(serialize_block_attributes(var_block_attributes.clone())).str() + ' '
	}).str())
	if !rt.is_true(var_block_content) {
		return rt.call_function('sprintf', [rt.new_string('<!-- wp:%s %s/-->'),
			var_serialized_block_name.clone(), var_serialized_attributes.clone()])
	}
	return rt.call_function('sprintf', [
		rt.new_string('<!-- wp:%s %s-->%s<!-- /wp:%s -->'),
		var_serialized_block_name.clone(),
		var_serialized_attributes.clone(),
		var_block_content.clone(),
		var_serialized_block_name.clone(),
	])
}

fn serialize_block(var_block rt.PhpVal) rt.PhpVal {
	mut var_block_content := ''
	mut var_index := i64(0)
	mut var_chunk := rt.new_null()
	var_block_content = ''
	var_index = 0
	mut iter_12 := var_block.array_get(rt.new_string('innerContent')).iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_chunk_shadow := item_12.val
		var_block_content = var_block_content +(if var_chunk_shadow.clone().is_string() { var_chunk_shadow } else { serialize_block(var_block.array_get(rt.new_string('innerBlocks')).array_get(rt.post_inc(rt.new_int(var_index)))) }).str()
	}
	if !(var_block.array_get(rt.new_string('attrs')).is_array()) {
		var_block.array_set('attrs', rt.new_array())
	}
	return get_comment_delimited_block_content(var_block.array_get(rt.new_string('blockName')),
		var_block.array_get(rt.new_string('attrs')), rt.new_string(var_block_content.str()).clone())
}

fn serialize_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	return rt.call_function('implode', [rt.new_string(''),
		rt.call_function('array_map', [rt.new_string('serialize_block'),
			var_blocks.clone()])])
}

fn traverse_and_serialize_block(var_block rt.PhpVal, var_pre_callback rt.PhpVal, var_post_callback rt.PhpVal) rt.PhpVal {
	mut var_block_content := ''
	mut var_block_index := i64(0)
	mut var_chunk := rt.new_null()
	mut var_inner_block := rt.new_null()
	mut var_prev := rt.new_null()
	mut var_next := rt.new_null()
	mut var_post_markup := rt.new_null()
	var_block_content = ''
	var_block_index = 0
	mut iter_13 := var_block.array_get(rt.new_string('innerContent')).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_chunk_shadow := item_13.val
		if rt.is_true(rt.new_bool(var_chunk_shadow.clone().is_string())) {
			var_block_content = var_block_content + var_chunk_shadow.str()
		} else {
			var_inner_block =
				var_block.array_get(rt.new_string('innerBlocks')).array_get(rt.new_int(var_block_index))
			if rt.is_true(rt.call_function('is_callable', [var_pre_callback.clone()])) {
				var_prev = if 0 == var_block_index {
					rt.new_null()
				} else {
					var_block.array_get(rt.new_string('innerBlocks')).array_get(rt.new_int(var_block_index - 1))
				}
				var_block_content = var_block_content +(rt.call_function('call_user_func_array', [var_pre_callback.clone(), rt.create_array([rt.ArrayItem{
					key: none
					val: var_inner_block
				}, rt.ArrayItem{ key: none, val: var_block }, rt.ArrayItem{ key: none, val: var_prev }])])).str()
			}
			if rt.is_true(rt.call_function('is_callable', [var_post_callback.clone()])) {
				var_next = if var_block.array_get(rt.new_string('innerBlocks')).array_count() - 1 == var_block_index {
					rt.new_null()
				} else {
					var_block.array_get(rt.new_string('innerBlocks')).array_get(rt.new_int(
						var_block_index + 1))
				}
				var_post_markup = rt.call_function('call_user_func_array', [
					var_post_callback.clone(),
					rt.create_array([
						rt.ArrayItem{ key: none, val: var_inner_block },
						rt.ArrayItem{ key: none, val: var_block },
						rt.ArrayItem{ key: none, val: var_next },
					])])
			}
			var_block_content = var_block_content +(traverse_and_serialize_block(var_inner_block.clone(), var_pre_callback.clone(), var_post_callback.clone())).str()
			var_block_content = var_block_content +
				(if !var_post_markup.is_null() { var_post_markup } else { rt.new_string('') }).str()
			var_block_index += 1
		}
	}
	if !(var_block.array_get(rt.new_string('attrs')).is_array()) {
		var_block.array_set('attrs', rt.new_array())
	}
	return get_comment_delimited_block_content(var_block.array_get(rt.new_string('blockName')),
		var_block.array_get(rt.new_string('attrs')), rt.new_string(var_block_content.str()).clone())
}

fn resolve_pattern_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_seen_refs := rt.new_null()
	mut var_i := i64(0)
	mut var_attrs := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_registry := rt.new_null()
	mut var_pattern := rt.new_null()
	mut var_blocks_to_insert := rt.new_null()
	mut var_block_metadata := rt.new_null()
	mut var_pattern_key := rt.new_null()
	mut var_key := rt.new_null()
	mut var_value := rt.new_null()
	mut var_prev_inner_content := rt.new_null()
	mut var_inner_content := rt.new_null()
	mut var_null_indices := rt.new_null()
	mut var_content_index := rt.new_null()
	mut var_nulls := rt.new_null()
	var_i = 0
	for var_i < var_blocks.clone().array_count() {
		if rt.is_true(rt.identical(rt.new_string('core/pattern'),
			var_blocks.array_get(rt.new_int(var_i)).array_get(rt.new_string('blockName'))))
		{
			var_attrs = var_blocks.array_get(rt.new_int(var_i)).array_get(rt.new_string('attrs'))
			if !rt.is_true(var_attrs.array_get(rt.new_string('slug'))) {
				var_i += 1
				continue
			}
			var_slug = var_attrs.array_get(rt.new_string('slug'))
			if var_seen_refs.array_isset(var_slug) {
				rt.call_function('array_splice', [var_blocks.clone(),
					rt.new_int(var_i).clone(), rt.new_int(1)])
				continue
			}
			mut iife_temp_16 := Class_WP_Block_Patterns_Registry{}
			mut iife_result_16 := iife_temp_16.get_instance()
			var_registry = iife_result_16
			var_pattern = rt.call_method(var_registry, 'get_registered', [
				var_slug.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_pattern)))) {
				var_i += 1
				continue
			}
			var_blocks_to_insert =
				parse_blocks(rt.new_string(var_pattern.array_get(rt.new_string('content')).to_string().trim_space()))
			if var_blocks_to_insert.clone().array_count() == 1 {
				var_block_metadata = if !(var_blocks_to_insert.array_get(rt.new_int(0)).array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata'))).is_null() {
					var_blocks_to_insert.array_get(rt.new_int(0)).array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata'))
				} else {
					rt.new_array()
				}
				var_block_metadata.array_set('patternName', var_slug.clone())
				mut iter_14 := rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'title' },
					rt.ArrayItem{ key: 'description', val: 'description' },
					rt.ArrayItem{ key: 'categories', val: 'categories' },
				]).iterator()
				for {
					item_14 := iter_14.next() or { break }
					mut var_pattern_key_shadow := item_14.val
					mut var_key_shadow := item_14.key
					var_value = if !(var_pattern.array_get(var_pattern_key_shadow)).is_null() {
						var_pattern.array_get(var_pattern_key_shadow)
					} else {
						if !(var_block_metadata.array_get(var_key_shadow)).is_null() {
							var_block_metadata.array_get(var_key_shadow)
						} else {
							rt.new_null()
						}
					}
					if rt.is_true(var_value) {
						var_block_metadata.array_set(var_key_shadow, if var_value.clone().is_array() { rt.call_function('array_map', [
								rt.new_string('sanitize_text_field'),
								var_value.clone(),
							]) } else { rt.call_function('sanitize_text_field', [
								var_value.clone(),
							]) })
					}
				}
				var_blocks_to_insert.array_get_mut(0).array_get_mut('attrs').array_set('metadata',
					var_block_metadata.clone())
			}
			var_seen_refs.array_set(var_slug, true)
			var_prev_inner_content = var_inner_content.clone()
			var_inner_content = rt.new_null()
			var_blocks_to_insert = resolve_pattern_blocks(var_blocks_to_insert.clone())
			var_inner_content = var_prev_inner_content.clone()
			var_seen_refs.array_unset(var_slug)
			rt.call_function('array_splice', [var_blocks.clone(),
				rt.new_int(var_i).clone(), rt.new_int(1), var_blocks_to_insert.clone()])
			if rt.is_true(var_inner_content) {
				var_null_indices = rt.func_array_keys(var_inner_content.clone(), rt.new_null(),
					rt.new_bool(true))
				var_content_index = var_null_indices.array_get(rt.new_int(var_i))
				var_nulls = rt.call_function('array_fill', [rt.new_int(0),
					rt.new_int(var_blocks_to_insert.clone().array_count()),
					rt.new_null()])
				rt.call_function('array_splice', [var_inner_content.clone(),
					var_content_index.clone(), rt.new_int(1),
					var_nulls.clone()])
			}
			var_i = var_i + var_blocks_to_insert.clone().array_count()
		} else {
			if !(!rt.is_true(var_blocks.array_get(rt.new_int(var_i)).array_get(rt.new_string('innerBlocks')))) {
				var_prev_inner_content = var_inner_content.clone()
				var_inner_content =
					var_blocks.array_get(rt.new_int(var_i)).array_get(rt.new_string('innerContent'))
				var_blocks.array_get_mut(var_i).array_set('innerBlocks',
					resolve_pattern_blocks(var_blocks.array_get(rt.new_int(var_i)).array_get(rt.new_string('innerBlocks'))))
				var_blocks.array_get_mut(var_i).array_set('innerContent', var_inner_content.clone())
				var_inner_content = var_prev_inner_content.clone()
			}
			var_i += 1
		}
	}
	return var_blocks.clone()
}

fn traverse_and_serialize_blocks(var_blocks rt.PhpVal, var_pre_callback rt.PhpVal, var_post_callback rt.PhpVal) string {
	mut var_result := ''
	mut var_parent_block := rt.new_null()
	mut var_pre_callback_is_callable := rt.new_null()
	mut var_post_callback_is_callable := rt.new_null()
	mut var_block := rt.new_null()
	mut var_index := rt.new_null()
	mut var_prev := rt.new_null()
	mut var_next := rt.new_null()
	mut var_post_markup := rt.new_null()
	var_result = ''
	var_parent_block = rt.new_null()
	var_pre_callback_is_callable = rt.call_function('is_callable', [
		var_pre_callback.clone()])
	var_post_callback_is_callable = rt.call_function('is_callable', [
		var_post_callback.clone()])
	mut iter_15 := var_blocks.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_block_shadow := item_15.val
		mut var_index_shadow := item_15.key
		if rt.is_true(var_pre_callback_is_callable) {
			var_prev = if rt.is_true(rt.identical(rt.new_int(0), var_index_shadow)) {
				rt.new_null()
			} else {
				var_blocks.array_get(rt.sub(var_index_shadow, rt.new_int(1)))
			}
			var_result = var_result +(rt.call_function('call_user_func_array', [var_pre_callback.clone(), rt.create_array([rt.ArrayItem{
				key: none
				val: var_block_shadow
			}, rt.ArrayItem{ key: none, val: var_parent_block }, rt.ArrayItem{
				key: none
				val: var_prev
			}])])).str()
		}
		if rt.is_true(var_post_callback_is_callable) {
			var_next = if rt.is_true(rt.identical(var_blocks.clone().array_count() - 1,
				var_index_shadow))
			{
				rt.new_null()
			} else {
				var_blocks.array_get(rt.add(var_index_shadow, rt.new_int(1)))
			}
			var_post_markup = rt.call_function('call_user_func_array', [
				var_post_callback.clone(),
				rt.create_array([
					rt.ArrayItem{ key: none, val: var_block_shadow },
					rt.ArrayItem{ key: none, val: var_parent_block },
					rt.ArrayItem{ key: none, val: var_next },
				])])
		}
		var_result = var_result +(traverse_and_serialize_block(var_block_shadow.clone(), var_pre_callback.clone(), var_post_callback.clone())).str()
		var_result = var_result +
			(if !var_post_markup.is_null() { var_post_markup } else { rt.new_string('') }).str()
	}
	return var_result
}

fn filter_block_content(var_text_arg rt.PhpVal, allowed_html string, var_allowed_protocols rt.PhpVal) string {
	mut var_allowed_html := allowed_html
	mut var_text := var_text_arg
	mut var_result := ''
	mut var_blocks := rt.new_null()
	mut var_block := rt.new_null()
	var_result = ''
	if rt.is_true(rt.call_function('str_contains', [var_text.clone(), rt.new_string('<!--')]))
		&& rt.is_true(rt.call_function('str_contains', [var_text.clone(), rt.new_string('--->')])) {
		var_text = rt.call_function('preg_replace_callback', [
			rt.new_string('%<!--(.*?)--->%'),
			rt.new_string('_filter_block_content_callback'),
			var_text.clone(),
		])
	}
	var_blocks = parse_blocks(var_text.clone())
	mut iter_16 := var_blocks.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_block_shadow := item_16.val
		var_block_shadow = filter_block_kses(var_block_shadow.clone(), rt.new_string(allowed_html),
			var_allowed_protocols.clone())
		var_result = var_result + (serialize_block(var_block_shadow.clone())).str()
	}
	return var_result
}

fn _filter_block_content_callback(var_matches rt.PhpVal) string {
	return '<!--' + var_matches.array_get(rt.new_int(1)).to_string().trim_right(' \t\n\r') + '-->'
}

fn filter_block_kses(var_block rt.PhpVal, var_allowed_html rt.PhpVal, var_allowed_protocols rt.PhpVal) rt.PhpVal {
	mut var_inner_block := rt.new_null()
	mut var_i := rt.new_null()
	var_block.array_set('attrs', filter_block_kses_value(var_block.array_get(rt.new_string('attrs')),
		var_allowed_html.clone(), var_allowed_protocols.clone(), var_block.clone()))
	if rt.is_true(rt.new_bool(var_block.array_get(rt.new_string('innerBlocks')).is_array())) {
		mut iter_17 := var_block.array_get(rt.new_string('innerBlocks')).iterator()
		for {
			item_17 := iter_17.next() or { break }
			mut var_inner_block_shadow := item_17.val
			mut var_i_shadow := item_17.key
			var_block.array_get_mut('innerBlocks').array_set(var_i_shadow, filter_block_kses(var_inner_block_shadow.clone(),
				var_allowed_html.clone(), var_allowed_protocols.clone()))
		}
	}
	return var_block.clone()
}

fn filter_block_kses_value(var_value rt.PhpVal, var_allowed_html rt.PhpVal, var_allowed_protocols rt.PhpVal, var_block_context rt.PhpVal) rt.PhpVal {
	mut var_inner_value := rt.new_null()
	mut var_key := rt.new_null()
	mut var_filtered_key := rt.new_null()
	mut var_filtered_value := rt.new_null()
	if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
		mut iter_18 := var_value.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_inner_value_shadow := item_18.val
			mut var_key_shadow := item_18.key
			var_filtered_key = filter_block_kses_value(var_key_shadow.clone(),
				var_allowed_html.clone(), var_allowed_protocols.clone(),
				rt.create_array_from_native_map(var_block_context))
			var_filtered_value = filter_block_kses_value(var_inner_value_shadow.clone(),
				var_allowed_html.clone(), var_allowed_protocols.clone(),
				rt.create_array_from_native_map(var_block_context))
			if var_block_context.array_isset(rt.new_string('blockName'))
				&& rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block_context.array_get(rt.new_string('blockName')))) {
				var_filtered_value = filter_block_core_template_part_attributes(var_filtered_value.clone(),
					var_filtered_key.clone(), var_allowed_html.clone())
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_filtered_key, var_key_shadow)))) {
				var_value.array_unset(var_key_shadow)
			}
			var_value.array_set(var_filtered_key, var_filtered_value.clone())
		}
	} else if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
		return rt.call_function('wp_kses', [var_value.clone(),
			var_allowed_html.clone(), var_allowed_protocols.clone()])
	}
	return var_value.clone()
}

fn filter_block_core_template_part_attributes(var_attribute_value rt.PhpVal, var_attribute_name rt.PhpVal, var_allowed_html_arg rt.PhpVal) rt.PhpVal {
	mut var_allowed_html := var_allowed_html_arg
	if !rt.is_true(var_attribute_value)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('tagName'), var_attribute_name)))) {
		return var_attribute_value.clone()
	}
	if !(var_allowed_html.clone().is_array()) {
		var_allowed_html = rt.call_function('wp_kses_allowed_html', [
			var_allowed_html.clone()])
	}
	return if var_allowed_html.array_isset(var_attribute_value) {
		var_attribute_value
	} else {
		rt.new_string('')
	}
}

fn excerpt_remove_blocks(var_content rt.PhpVal) string {
	mut var_allowed_inner_blocks := []rt.PhpVal{}
	mut var_allowed_wrapper_blocks := rt.new_null()
	mut var_allowed_blocks := rt.new_null()
	mut var_blocks := rt.new_null()
	mut var_output := ''
	mut var_block := rt.new_null()
	mut var_inner_block := rt.new_null()
	if !(has_blocks(var_content.clone())) {
		return var_content.str()
	}
	var_allowed_inner_blocks = [rt.new_null(), rt.new_string('core/freeform'),
		rt.new_string('core/heading'), rt.new_string('core/html'),
		rt.new_string('core/list'), rt.new_string('core/media-text'),
		rt.new_string('core/paragraph'), rt.new_string('core/preformatted'),
		rt.new_string('core/pullquote'), rt.new_string('core/quote'),
		rt.new_string('core/table'), rt.new_string('core/verse')]
	var_allowed_wrapper_blocks = rt.create_array([
		rt.ArrayItem{ key: none, val: 'core/columns' },
		rt.ArrayItem{ key: none, val: 'core/column' },
		rt.ArrayItem{ key: none, val: 'core/group' },
	])
	var_allowed_wrapper_blocks = rt.call_function('apply_filters', [
		rt.new_string('excerpt_allowed_wrapper_blocks'),
		var_allowed_wrapper_blocks.clone(),
	])
	var_allowed_blocks = rt.call_function('array_merge', [
		rt.create_array_from_list(var_allowed_inner_blocks),
		var_allowed_wrapper_blocks.clone(),
	])
	var_allowed_blocks = rt.call_function('apply_filters', [
		rt.new_string('excerpt_allowed_blocks'),
		var_allowed_blocks.clone(),
	])
	var_blocks = parse_blocks(var_content.clone())
	var_output = ''
	mut iter_19 := var_blocks.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_block_shadow := item_19.val
		if rt.is_true(rt.call_function('in_array', [
			var_block_shadow.array_get(rt.new_string('blockName')),
			var_allowed_blocks.clone(),
			rt.new_bool(true),
		]))
		{
			if !(!rt.is_true(var_block_shadow.array_get(rt.new_string('innerBlocks')))) {
				if rt.is_true(rt.call_function('in_array', [
					var_block_shadow.array_get(rt.new_string('blockName')),
					var_allowed_wrapper_blocks.clone(),
					rt.new_bool(true),
				]))
				{
					var_output = var_output +
						_excerpt_render_inner_blocks(var_block_shadow.clone(), var_allowed_blocks.clone())
					continue
				}
				mut iter_20 := var_block_shadow.array_get(rt.new_string('innerBlocks')).iterator()
				for {
					item_20 := iter_20.next() or { break }
					mut var_inner_block_shadow := item_20.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_inner_block_shadow.array_get(rt.new_string('blockName')), rt.create_array_from_list(var_allowed_inner_blocks), rt.new_bool(true)])))))
						|| !(!rt.is_true(var_inner_block_shadow.array_get(rt.new_string('innerBlocks')))) {
						continue
					}
				}
			}
			var_output = var_output + (render_block(var_block_shadow.clone())).str()
		}
	}
	return var_output
}

fn excerpt_remove_footnotes(var_content rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_content.clone(), rt.new_string('data-fn=')])))))
	{
		return var_content.clone()
	}
	return rt.call_function('preg_replace', [
		rt.new_string('_<sup data-fn="[^"]+" class="[^"]+">\\s*<a href="[^"]+" id="[^"]+">\\d+</a>\\s*</sup>_'),
		rt.new_string(''),
		var_content.clone(),
	])
}

fn _excerpt_render_inner_blocks(var_parsed_block rt.PhpVal, var_allowed_blocks rt.PhpVal) string {
	mut var_output := ''
	mut var_inner_block := rt.new_null()
	var_output = ''
	mut iter_21 := var_parsed_block.array_get(rt.new_string('innerBlocks')).iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_inner_block_shadow := item_21.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_inner_block_shadow.array_get(rt.new_string('blockName')),
			var_allowed_blocks.clone(),
			rt.new_bool(true),
		])))))
		{
			continue
		}
		if !rt.is_true(var_inner_block_shadow.array_get(rt.new_string('innerBlocks'))) {
			var_output = var_output + (render_block(var_inner_block_shadow.clone())).str()
		} else {
			var_output = var_output +
				_excerpt_render_inner_blocks(var_inner_block_shadow.clone(), var_allowed_blocks.clone())
		}
	}
	return var_output
}

fn render_block(var_parsed_block_arg rt.PhpVal) rt.PhpVal {
	mut var_parsed_block := var_parsed_block_arg
	mut var_post := rt.new_null()
	mut var_parent_block := rt.new_null()
	mut var_pre_render := rt.new_null()
	mut var_source_block := rt.new_null()
	mut var_context := rt.new_null()
	mut var_block := rt.new_null()
	var_parent_block = rt.new_null()
	var_pre_render = rt.call_function('apply_filters', [
		rt.new_string('pre_render_block'),
		rt.new_null(),
		var_parsed_block.clone(),
		var_parent_block.clone(),
	])
	if !(var_pre_render.clone().is_null()) {
		return var_pre_render.clone()
	}
	var_source_block = var_parsed_block.clone()
	var_parsed_block = rt.call_function('apply_filters', [
		rt.new_string('render_block_data'),
		var_parsed_block.clone(),
		var_source_block.clone(),
		var_parent_block.clone(),
	])
	var_context = rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
		var_context.array_set('postId', rt.get_property(var_post, 'ID'))
		var_context.array_set('postType', rt.get_property(var_post, 'post_type'))
	}
	var_context = rt.call_function('apply_filters', [
		rt.new_string('render_block_context'),
		var_context.clone(),
		var_parsed_block.clone(),
		var_parent_block.clone(),
	])
	var_block = create_wp_block(var_parsed_block.clone(), var_context.clone())
	return rt.call_method(var_block, 'render', []rt.PhpVal{})
}

fn parse_blocks(var_content rt.PhpVal) rt.PhpVal {
	mut var_parser_class := rt.new_null()
	mut var_parser := rt.new_null()
	var_parser_class = rt.call_function('apply_filters', [
		rt.new_string('block_parser_class'),
		rt.new_string('WP_Block_Parser'),
	])
	var_parser = rt.create_object_dynamically(var_parser_class, []rt.PhpVal{})
	return rt.call_method(var_parser, 'parse', [var_content.clone()])
}

fn do_blocks(var_content rt.PhpVal) string {
	mut var_blocks := rt.new_null()
	mut var_top_level_block_count := i64(0)
	mut var_output := ''
	mut var_i := i64(0)
	mut var_priority := rt.new_null()
	var_blocks = parse_blocks(var_content.clone())
	var_top_level_block_count = var_blocks.clone().array_count()
	var_output = ''
	var_i = 0
	for {
		if !(var_i < var_top_level_block_count) { break
		 }
		var_output = var_output + (render_block(var_blocks.array_get(rt.new_int(var_i)))).str()
		var_blocks.array_set(var_i, rt.new_null())
		var_i += 1
	}
	var_priority = rt.call_function('has_filter', [rt.new_string('the_content'),
		rt.new_string('wpautop')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_priority))))
		&& rt.is_true(rt.call_function('doing_filter', [rt.new_string('the_content')]))
		&& has_blocks(var_content.clone()) {
		rt.call_function('remove_filter', [rt.new_string('the_content'),
			rt.new_string('wpautop'), var_priority.clone()])
		rt.call_function('add_filter', [rt.new_string('the_content'),
			rt.new_string('_restore_wpautop_hook'), rt.add(var_priority, rt.new_int(1))])
	}
	return var_output
}

fn _restore_wpautop_hook(var_content rt.PhpVal) rt.PhpVal {
	mut var_current_priority := rt.new_null()
	var_current_priority = rt.call_function('has_filter', [rt.new_string('the_content'),
		rt.new_string('_restore_wpautop_hook')])
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.new_string('wpautop'), rt.sub(var_current_priority, rt.new_int(1))])
	rt.call_function('remove_filter', [rt.new_string('the_content'),
		rt.new_string('_restore_wpautop_hook'), var_current_priority.clone()])
	return var_content.clone()
}

fn block_version(var_content rt.PhpVal) i64 {
	return if has_blocks(var_content.clone()) { 1 } else { 0 }
}

fn register_block_style(var_block_name rt.PhpVal, var_style_properties rt.PhpVal) rt.PhpVal {
	mut iife_temp_17 := Class_WP_Block_Styles_Registry{}
	mut iife_result_17 := iife_temp_17.get_instance()
	return rt.call_method(iife_result_17, 'register', [var_block_name.clone(),
		var_style_properties.clone()])
}

fn unregister_block_style(var_block_name rt.PhpVal, var_block_style_name rt.PhpVal) rt.PhpVal {
	mut iife_temp_18 := Class_WP_Block_Styles_Registry{}
	mut iife_result_18 := iife_temp_18.get_instance()
	return rt.call_method(iife_result_18, 'unregister', [var_block_name.clone(),
		var_block_style_name.clone()])
}

fn block_has_support(var_block_type rt.PhpVal, feature string, default_value bool) bool {
	mut var_feature := feature
	mut var_default_value := default_value
	mut var_block_support := rt.new_null()
	var_block_support = rt.new_bool(default_value)
	if rt.is_true(rt.new_bool(rt.instance_of(var_block_type, 'WP_Block_Type'))) {
		if rt.new_string(var_feature.str()).is_array()
			&& rt.new_string(var_feature.str()).array_count() == 1 {
			var_feature = (rt.new_string(var_feature.str()).array_get(rt.new_int(0))).str()
		}
		if rt.is_true(rt.new_bool(rt.new_string(var_feature.str()).is_array())) {
			var_block_support = rt.call_function('_wp_array_get', [
				rt.get_property(var_block_type, 'supports'),
				rt.new_string(var_feature.str()),
				rt.new_bool(default_value),
			])
		} else if rt.get_property(var_block_type, 'supports').array_isset(rt.new_string(var_feature.str())) {
			var_block_support =
				rt.get_property(var_block_type, 'supports').array_get(rt.new_string(var_feature.str()))
		}
	}
	return rt.is_true(rt.identical(rt.new_bool(true), var_block_support))
		|| var_block_support.clone().is_array()
}

fn wp_migrate_old_typography_shape(var_metadata rt.PhpVal) rt.PhpVal {
	mut var_typography_keys := []rt.PhpVal{}
	mut var_typography_key := rt.new_null()
	mut var_support_for_key := rt.new_null()
	if !(var_metadata.array_isset(rt.new_string('supports'))) {
		return var_metadata.clone()
	}
	var_typography_keys = ['__experimentalFontFamily', '__experimentalFontStyle',
		'__experimentalFontWeight', '__experimentalLetterSpacing', '__experimentalTextDecoration',
		'__experimentalTextTransform', 'fontSize', 'lineHeight']
	for var_typography_key_shadow in var_typography_keys {
		var_support_for_key = if !(var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string(var_typography_key_shadow.str()))).is_null() {
			var_metadata.array_get(rt.new_string('supports')).array_get(rt.new_string(var_typography_key_shadow.str()))
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_support_for_key)))) {
			rt.call_function('_doing_it_wrong', [
				rt.new_string('register_block_type_from_metadata()'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Block "%1$s" is declaring %2$s support in %3$s file under %4$s. %2$s support is now declared under %5$s.'),
					]),
					var_metadata.array_get(rt.new_string('name')),
					rt.new_string('<code>${var_typography_key.to_string()}</code>'),
					rt.new_string('<code>block.json</code>'),
					rt.new_string('<code>supports.${var_typography_key.to_string()}</code>'),
					rt.new_string('<code>supports.typography.${var_typography_key.to_string()}</code>'),
				]),
				rt.new_string('5.8.0'),
			])
			rt.call_function('_wp_array_set', [var_metadata.array_get(rt.new_string('supports')),
				rt.create_array([rt.ArrayItem{ key: none, val: 'typography' },
					rt.ArrayItem{ key: none, val: rt.new_string(var_typography_key_shadow.str()) }]),
				var_support_for_key.clone()])
			var_metadata.array_get(rt.new_string('supports')).array_unset(rt.new_string(var_typography_key_shadow.str()))
		}
	}
	return var_metadata.clone()
}

fn build_query_vars_from_query_block(var_block rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_query := map[string]rt.PhpVal{}
	mut var_post_type_param := rt.new_null()
	mut var_sticky := rt.new_null()
	mut var_excluded_post_ids := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_offset := rt.new_null()
	mut var_tax_query_back_compat := []rt.PhpVal{}
	mut var_tax_query_input := rt.new_null()
	mut var_tax_query := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_build_conditions := rt.new_null()
	mut var_exclude_terms := rt.new_null()
	mut var_include_terms := rt.new_null()
	mut var_formats := rt.new_null()
	mut var_valid_formats := rt.new_null()
	mut var_formats_query := rt.new_null()
	var_query = {
		'post_type':    rt.new_string('post')
		'order':        rt.new_string('DESC')
		'orderby':      rt.new_string('date')
		'post__not_in': rt.new_array()
		'tax_query':    rt.new_array()
	}
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('query')) {
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('postType')))) {
			var_post_type_param =
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('postType'))
			if rt.is_true(rt.call_function('is_post_type_viewable', [
				var_post_type_param.clone()]))
			{
				var_query['post_type'] = var_post_type_param.clone()
			}
		}
		if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('sticky'))
			&& !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('sticky')))) {
			var_sticky = rt.call_function('get_option', [rt.new_string('sticky_posts')])
			if rt.is_true(rt.identical(rt.new_string('only'),
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('sticky'))))
			{
				var_query['post__in'] = if !(!rt.is_true(var_sticky)) { var_sticky } else { rt.create_array([
						rt.ArrayItem{ key: none, val: 0 },
					]) }
				var_query['ignore_sticky_posts'] = rt.new_int(1)
			} else if rt.is_true(rt.identical(rt.new_string('exclude'), rt.get_property(var_block,
				'context').array_get(rt.new_string('query')).array_get(rt.new_string('sticky'))))
			{
				var_query['post__not_in'] = rt.call_function('array_merge', [
					var_query['post__not_in'],
					var_sticky.clone(),
				])
			} else if rt.is_true(rt.identical(rt.new_string('ignore'), rt.get_property(var_block,
				'context').array_get(rt.new_string('query')).array_get(rt.new_string('sticky'))))
			{
				var_query['ignore_sticky_posts'] = rt.new_int(1)
			}
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('exclude')))) {
			var_excluded_post_ids = rt.call_function('array_map', [
				rt.new_string('intval'),
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('exclude')),
			])
			var_excluded_post_ids = rt.call_function('array_filter', [
				var_excluded_post_ids.clone()])
			var_query['post__not_in'] = rt.call_function('array_merge', [
				var_query['post__not_in'],
				var_excluded_post_ids.clone(),
			])
		}
		if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('perPage'))
			&& rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('perPage')).is_long()
			|| rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('perPage')).is_double() {
			var_per_page = rt.call_function('absint', [
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('perPage')),
			])
			var_offset = rt.new_int(0)
			if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('offset'))
				&& rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('offset')).is_long()
				|| rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('offset')).is_double() {
				var_offset = rt.call_function('absint', [
					rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('offset')),
				])
			}
			var_query['offset'] = rt.add(rt.mul(var_per_page, rt.sub(var_page, rt.new_int(1))),
				var_offset)
			var_query['posts_per_page'] = var_per_page.clone()
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('categoryIds'))))
			|| !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('tagIds')))) {
			var_tax_query_back_compat = rt.new_array()
			if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('categoryIds')))) {
				var_tax_query_back_compat << rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'category' },
					rt.ArrayItem{ key: 'terms', val: rt.call_function('array_filter', [
						rt.call_function('array_map', [rt.new_string('intval'),
							rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('categoryIds'))]),
					]) },
					rt.ArrayItem{ key: 'include_children', val: false },
				])
			}
			if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('tagIds')))) {
				var_tax_query_back_compat << rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'post_tag' },
					rt.ArrayItem{ key: 'terms', val: rt.call_function('array_filter', [
						rt.call_function('array_map', [rt.new_string('intval'),
							rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('tagIds'))]),
					]) },
					rt.ArrayItem{ key: 'include_children', val: false },
				])
			}
			var_query['tax_query'] = rt.call_function('array_merge', [var_query['tax_query'],
				rt.create_array_from_list(var_tax_query_back_compat)])
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('taxQuery'))))
			&& rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('taxQuery')).is_array() {
			var_tax_query_input =
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('taxQuery'))
			var_tax_query = rt.new_array()
			if !(!rt.is_true(rt.call_function('array_diff', [
				rt.func_array_keys(var_tax_query_input.clone()),
				rt.create_array([rt.ArrayItem{ key: none, val: 'include' },
					rt.ArrayItem{ key: none, val: 'exclude' }]),
			]))) {
				mut iter_22 :=
					rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('taxQuery')).iterator()
				for {
					item_22 := iter_22.next() or { break }
					mut var_terms_shadow := item_22.val
					mut var_taxonomy_shadow := item_22.key
					if rt.is_true(rt.call_function('is_taxonomy_viewable', [var_taxonomy_shadow.clone()]))
						&& !(!rt.is_true(var_terms_shadow)) {
						var_tax_query.array_push(rt.create_array([
							rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_shadow },
							rt.ArrayItem{ key: 'terms', val: rt.call_function('array_filter', [
								rt.call_function('array_map', [
									rt.new_string('intval'), var_terms_shadow.clone()]),
							]) },
							rt.ArrayItem{ key: 'include_children', val: false },
						]))
					}
				}
			} else {
				closure_20_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_terms := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					mut var_operator := if args.len > 1 { args[1].clone() } else { rt.new_null() }
					var_terms = rt.cast_array(var_terms)
					mut var_conditions := rt.new_array()
					mut iter_23 := var_terms.iterator()
					for {
						item_23 := iter_23.next() or { break }
						mut var_tax_terms := item_23.val
						mut var_taxonomy := item_23.key
						if !(!rt.is_true(var_tax_terms))
							&& rt.is_true(rt.call_function('is_taxonomy_viewable', [var_taxonomy.clone()])) {
							var_conditions.array_push(rt.create_array([
								rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
								rt.ArrayItem{ key: 'terms', val: rt.call_function('array_filter', [
									rt.call_function('array_map', [
										rt.new_string('intval'),
										var_tax_terms.clone(),
									]),
								]) },
								rt.ArrayItem{ key: 'operator', val: var_operator },
								rt.ArrayItem{ key: 'include_children', val: false },
							]))
						}
					}
					return var_conditions.clone()
				}
				var_build_conditions = rt.new_closure(closure_20_fn)
				var_exclude_terms = if var_tax_query_input.array_isset(rt.new_string('exclude'))
					&& var_tax_query_input.array_get(rt.new_string('exclude')).is_array() {
					var_tax_query_input.array_get(rt.new_string('exclude'))
				} else {
					rt.new_array()
				}
				var_include_terms = if var_tax_query_input.array_isset(rt.new_string('include'))
					&& var_tax_query_input.array_get(rt.new_string('include')).is_array() {
					var_tax_query_input.array_get(rt.new_string('include'))
				} else {
					rt.new_array()
				}
				var_tax_query = rt.call_function('array_merge', [
					rt.call_callable(var_build_conditions, [var_include_terms.clone()]),
					rt.call_callable(var_build_conditions, [var_exclude_terms.clone(),
						rt.new_string('NOT IN')]),
				])
			}
			if !(!rt.is_true(var_tax_query)) {
				var_query['tax_query'] = rt.call_function('array_merge', [
					var_query['tax_query'],
					var_tax_query.clone(),
				])
			}
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('format'))))
			&& rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('format')).is_array() {
			var_formats =
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('format'))
			var_valid_formats = rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'standard' }]),
				rt.call_function('get_post_format_slugs', []rt.PhpVal{}),
			])
			var_formats = rt.call_function('array_intersect', [
				var_formats.clone(), var_valid_formats.clone()])
			var_formats_query = rt.create_array([
				rt.ArrayItem{ key: 'relation', val: 'OR' },
			])
			if rt.is_true(rt.call_function('in_array', [rt.new_string('standard'),
				var_formats.clone(), rt.new_bool(true)]))
			{
				var_formats_query.array_push(rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'post_format' },
					rt.ArrayItem{ key: 'field', val: 'slug' },
					rt.ArrayItem{ key: 'operator', val: 'NOT EXISTS' },
				]))
				var_formats.array_unset(rt.call_function('array_search', [
					rt.new_string('standard'),
					var_formats.clone(),
					rt.new_bool(true),
				]))
			}
			if !(!rt.is_true(var_formats)) {
				closure_21_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_format := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_string('post-format-${var_format.to_string()}')
				}
				closure_22_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_format := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return rt.new_string('post-format-${var_format.to_string()}')
				}
				var_terms = rt.call_function('array_map', [rt.new_closure(closure_21_fn),
					var_formats.clone()])
				var_formats_query.array_push(rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: 'post_format' },
					rt.ArrayItem{ key: 'field', val: 'slug' },
					rt.ArrayItem{ key: 'terms', val: var_terms },
					rt.ArrayItem{ key: 'operator', val: 'IN' },
				]))
			}
			if var_formats_query.clone().array_count() > 1 {
				if !rt.is_true(var_query['tax_query']) {
					var_query['tax_query'] = var_formats_query.clone()
				} else {
					var_query['tax_query'] = rt.create_array([
						rt.ArrayItem{ key: 'relation', val: 'AND' },
						rt.ArrayItem{ key: none, val: var_query['tax_query'] },
						rt.ArrayItem{ key: none, val: var_formats_query },
					])
				}
			}
		}
		if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('order'))
			&& rt.is_true(rt.call_function('in_array', [rt.new_string(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('order')).to_string().to_upper()), rt.create_array([rt.ArrayItem{
			key: none
			val: 'ASC'
		}, rt.ArrayItem{ key: none, val: 'DESC' }]), rt.new_bool(true)])) {
			var_query['order'] =
				rt.new_string(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('order')).to_string().to_upper())
		}
		if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('orderBy')) {
			var_query['orderby'] =
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('orderBy'))
		}
		if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('author')) {
			if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author')).is_array())) {
				var_query['author__in'] = rt.call_function('array_filter', [
					rt.call_function('array_map', [rt.new_string('intval'),
						rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author'))]),
				])
			} else if rt.is_true(rt.new_bool(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author')).is_string())) {
				var_query['author__in'] = rt.call_function('array_filter', [
					rt.call_function('array_map', [rt.new_string('intval'),
						rt.call_function('explode', [rt.new_string(','),
							rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author'))])]),
				])
			} else if
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author')).is_long()
				&& rt.is_true(rt.greater(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author')), rt.new_int(0))) {
				var_query['author'] =
					rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('author'))
			}
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('search')))) {
			var_query['s'] =
				rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('search'))
		}
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('parents'))))
			&& rt.is_true(rt.call_function('is_post_type_hierarchical', [var_query['post_type']])) {
			var_query['post_parent__in'] = rt.call_function('array_unique', [
				rt.call_function('array_map', [rt.new_string('intval'),
					rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('parents'))]),
			])
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('query_loop_block_query_vars'),
		rt.create_array_from_native_map(var_query),
		var_block.clone(),
		var_page.clone(),
	])
}

fn get_query_pagination_arrow(var_block rt.PhpVal, var_is_next rt.PhpVal) rt.PhpVal {
	mut var_arrow_map := rt.new_null()
	mut var_pagination_type := ''
	mut var_arrow_attribute := rt.new_null()
	mut var_arrow := rt.new_null()
	mut var_arrow_classes := ''
	var_arrow_map = rt.create_array([rt.ArrayItem{ key: 'none', val: '' },
		rt.ArrayItem{ key: 'arrow', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '→' },
			rt.ArrayItem{ key: 'previous', val: '←' },
		]) }, rt.ArrayItem{ key: 'chevron', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '»' },
			rt.ArrayItem{ key: 'previous', val: '«' },
		]) }])
	if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('paginationArrow'))))
		&& rt.is_true(rt.new_bool(var_arrow_map.clone().array_isset(rt.get_property(var_block, 'context').array_get(rt.new_string('paginationArrow')))))
		&& !(!rt.is_true(var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('paginationArrow'))))) {
		var_pagination_type = if rt.is_true(var_is_next) { 'next' } else { 'previous' }
		var_arrow_attribute =
			rt.get_property(var_block, 'context').array_get(rt.new_string('paginationArrow'))
		var_arrow =
			var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('paginationArrow'))).array_get(rt.new_string(var_pagination_type.str()))
		var_arrow_classes = 'wp-block-query-pagination-${var_pagination_type}-arrow is-arrow-${var_arrow_attribute.to_string()}'
		return rt.new_string("<span class='${var_arrow_classes}' aria-hidden='true'>${var_arrow.to_string()}</span>")
	}
	return rt.new_null()
}

fn build_comment_query_vars_from_block(var_block rt.PhpVal) rt.PhpVal {
	mut var_comment_args := map[string]rt.PhpVal{}
	mut var_unapproved_email := rt.new_null()
	mut var_per_page := rt.new_null()
	mut var_default_page := rt.new_null()
	mut var_page := rt.new_null()
	mut var_max_num_pages := rt.new_null()
	var_comment_args = {
		'orderby':       rt.new_string('comment_date_gmt')
		'order':         rt.new_string('ASC')
		'status':        rt.new_string('approve')
		'no_found_rows': rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_comment_args['include_unapproved'] = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
		])
	} else {
		var_unapproved_email = rt.call_function('wp_get_unapproved_comment_author_email',
			[]rt.PhpVal{})
		if rt.is_true(var_unapproved_email) {
			var_comment_args['include_unapproved'] = rt.create_array([
				rt.ArrayItem{ key: none, val: var_unapproved_email },
			])
		}
	}
	if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('postId')))) {
		var_comment_args['post_id'] =
			rt.new_int((rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))).to_i64())
	}
	if rt.is_true(rt.call_function('get_option', [rt.new_string('thread_comments')])) {
		var_comment_args['hierarchical'] = rt.new_string('threaded')
	} else {
		var_comment_args['hierarchical'] = rt.new_bool(false)
	}
	if rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('page_comments')]), rt.new_string('1')))
		|| rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('page_comments')]), rt.new_bool(true))) {
		var_per_page = rt.call_function('get_option', [
			rt.new_string('comments_per_page'),
		])
		var_default_page = rt.call_function('get_option', [
			rt.new_string('default_comments_page'),
		])
		if rt.is_true(rt.greater(var_per_page, rt.new_int(0))) {
			var_comment_args['number'] = var_per_page.clone()
			var_page = rt.new_int((rt.call_function('get_query_var', [
				rt.new_string('cpage'),
			])).to_i64())
			if rt.is_true(var_page) {
				var_comment_args['paged'] = var_page.clone()
			} else if rt.is_true(rt.identical(rt.new_string('oldest'), var_default_page)) {
				var_comment_args['paged'] = rt.new_int(1)
			} else if rt.is_true(rt.identical(rt.new_string('newest'), var_default_page)) {
				var_max_num_pages = rt.new_int((rt.get_property(create_wp_comment_query(var_comment_args.clone()),
					'max_num_pages')).to_i64())
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_max_num_pages)))) {
					var_comment_args['paged'] = var_max_num_pages.clone()
				}
			}
		}
	}
	return var_comment_args.clone()
}

fn get_comments_pagination_arrow(var_block rt.PhpVal, pagination_type string) rt.PhpVal {
	mut var_pagination_type := pagination_type
	mut var_arrow_map := rt.new_null()
	mut var_arrow_attribute := rt.new_null()
	mut var_arrow := rt.new_null()
	mut var_arrow_classes := ''
	var_arrow_map = rt.create_array([rt.ArrayItem{ key: 'none', val: '' },
		rt.ArrayItem{ key: 'arrow', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '→' },
			rt.ArrayItem{ key: 'previous', val: '←' },
		]) }, rt.ArrayItem{ key: 'chevron', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '»' },
			rt.ArrayItem{ key: 'previous', val: '«' },
		]) }])
	if !(!rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('comments/paginationArrow'))))
		&& !(!rt.is_true(var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('comments/paginationArrow'))).array_get(rt.new_string(pagination_type)))) {
		var_arrow_attribute =
			rt.get_property(var_block, 'context').array_get(rt.new_string('comments/paginationArrow'))
		var_arrow =
			var_arrow_map.array_get(rt.get_property(var_block, 'context').array_get(rt.new_string('comments/paginationArrow'))).array_get(rt.new_string(pagination_type))
		var_arrow_classes = 'wp-block-comments-pagination-${var_pagination_type}-arrow is-arrow-${var_arrow_attribute.to_string()}'
		return rt.new_string("<span class='${var_arrow_classes}' aria-hidden='true'>${var_arrow.to_string()}</span>")
	}
	return rt.new_null()
}

fn _wp_filter_post_meta_footnotes(var_footnotes rt.PhpVal) string {
	mut var_footnotes_decoded := rt.new_null()
	mut var_footnotes_sanitized := []rt.PhpVal{}
	mut var_footnote := map[string]rt.PhpVal{}
	var_footnotes_decoded = rt.call_function('json_decode', [
		var_footnotes.clone(), rt.new_bool(true)])
	if !(var_footnotes_decoded.clone().is_array()) {
		return ''
	}
	var_footnotes_sanitized = rt.new_array()
	mut iter_24 := var_footnotes_decoded.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_footnote_shadow := item_24.val
		if !(!rt.is_true(var_footnote_shadow['content']))
			&& !(!rt.is_true(var_footnote_shadow['id'])) {
			var_footnotes_sanitized << rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.call_function('sanitize_key', [
					var_footnote_shadow['id'],
				]) },
				rt.ArrayItem{ key: 'content', val: rt.call_function('wp_unslash', [
					rt.call_function('wp_filter_post_kses', [
						rt.call_function('wp_slash', [var_footnote_shadow['content']]),
					]),
				]) },
			])
		}
	}
	return (rt.call_function('wp_json_encode', [
		rt.create_array_from_list(var_footnotes_sanitized),
	])).str()
}

fn _wp_footnotes_kses_init_filters() {
	rt.call_function('add_filter', [rt.new_string('sanitize_post_meta_footnotes'),
		rt.new_string('_wp_filter_post_meta_footnotes')])
}

fn _wp_footnotes_remove_filters() {
	rt.call_function('remove_filter', [rt.new_string('sanitize_post_meta_footnotes'),
		rt.new_string('_wp_filter_post_meta_footnotes')])
}

fn _wp_footnotes_kses_init() {
	_wp_footnotes_remove_filters()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('unfiltered_html'),
	])))))
	{
		_wp_footnotes_kses_init_filters()
	}
}

fn _wp_footnotes_force_filtered_html_on_import_filter(var_arg rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_arg) {
		_wp_footnotes_kses_init_filters()
	}
	return var_arg.clone()
}

fn _wp_enqueue_auto_register_blocks() {
	mut var_auto_register_blocks := []rt.PhpVal{}
	mut var_registered_blocks := rt.new_null()
	mut var_block_type := rt.new_null()
	mut var_block_name := rt.new_null()
	var_auto_register_blocks = rt.new_array()
	mut iife_temp_22 := Class_WP_Block_Type_Registry{}
	mut iife_result_22 := iife_temp_22.get_instance()
	var_registered_blocks = rt.call_method(iife_result_22, 'get_all_registered', []rt.PhpVal{})
	mut iter_25 := var_registered_blocks.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_block_type_shadow := item_25.val
		mut var_block_name_shadow := item_25.key
		if !(!rt.is_true(rt.get_property(var_block_type_shadow, 'supports').array_get(rt.new_string('autoRegister'))))
			&& !(!rt.is_true(rt.get_property(var_block_type_shadow, 'render_callback'))) {
			var_auto_register_blocks << var_block_name_shadow.clone()
		}
	}
	if !(!rt.is_true(var_auto_register_blocks)) {
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-block-library'),
			rt.call_function('sprintf', [
				rt.new_string('window.__unstableAutoRegisterBlocks = %s;'),
				rt.call_function('wp_json_encode', [
					rt.create_array_from_list(var_auto_register_blocks),
				]),
			]),
			rt.new_string('before')])
	}
}

struct Class_WP_Block_Metadata_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Post {
	rt.PhpObjectBase
}

struct Class_WP_Block_Patterns_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

fn create_wp_block_metadata_registry(_args ...rt.PhpVal) &Class_WP_Block_Metadata_Registry {
	mut obj := &Class_WP_Block_Metadata_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_post(_args ...rt.PhpVal) &Class_WP_Post {
	mut obj := &Class_WP_Post{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_patterns_registry(_args ...rt.PhpVal) &Class_WP_Block_Patterns_Registry {
	mut obj := &Class_WP_Block_Patterns_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_styles_registry(_args ...rt.PhpVal) &Class_WP_Block_Styles_Registry {
	mut obj := &Class_WP_Block_Styles_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment_query(_args ...rt.PhpVal) &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Metadata_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Metadata_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Metadata_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Post) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Post) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Post) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Patterns_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Patterns_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Styles_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Styles_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_func('remove_block_asset_path_prefix', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return remove_block_asset_path_prefix(arg_0)
	})
	rt.register_func('generate_block_asset_handle', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return generate_block_asset_handle(arg_0, arg_1, arg_2)
	})
	rt.register_func('get_block_asset_url', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(get_block_asset_url(arg_0))
	})
	rt.register_func('register_block_script_module_id', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_script_module_id(arg_0, arg_1, arg_2))
	})
	rt.register_func('register_block_script_handle', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_script_handle(arg_0, arg_1, arg_2))
	})
	rt.register_func('register_block_style_handle', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
		return rt.new_bool(register_block_style_handle(arg_0, arg_1, arg_2))
	})
	rt.register_func('get_block_metadata_i18n_schema', fn (args []rt.PhpVal) rt.PhpVal {
		return get_block_metadata_i18n_schema()
	})
	rt.register_func('wp_register_block_types_from_metadata_collection', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return wp_register_block_types_from_metadata_collection(arg_0, arg_1)
	})
	rt.register_func('wp_register_block_metadata_collection', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return wp_register_block_metadata_collection(arg_0, arg_1)
	})
	rt.register_func('register_block_type_from_metadata', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(register_block_type_from_metadata(arg_0, arg_1))
	})
	rt.register_func('register_block_type', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(register_block_type(arg_0, arg_1))
	})
	rt.register_func('unregister_block_type', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return unregister_block_type(arg_0)
	})
	rt.register_func('has_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(has_blocks(arg_0))
	})
	rt.register_func('has_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(has_block(arg_0, arg_1))
	})
	rt.register_func('get_dynamic_block_names', fn (args []rt.PhpVal) rt.PhpVal {
		return get_dynamic_block_names()
	})
	rt.register_func('get_hooked_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		return get_hooked_blocks()
	})
	rt.register_func('insert_hooked_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(insert_hooked_blocks(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('set_ignored_hooked_blocks_metadata', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(set_ignored_hooked_blocks_metadata(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('apply_block_hooks_to_content', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return apply_block_hooks_to_content(arg_0, arg_1, arg_2)
	})
	rt.register_func('apply_block_hooks_to_content_from_post_object', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return apply_block_hooks_to_content_from_post_object(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('remove_serialized_parent_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return remove_serialized_parent_block(arg_0)
	})
	rt.register_func('extract_serialized_parent_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(extract_serialized_parent_block(arg_0))
	})
	rt.register_func('update_ignored_hooked_blocks_postmeta', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return update_ignored_hooked_blocks_postmeta(arg_0)
	})
	rt.register_func('insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata(arg_0,
			arg_1, arg_2, arg_3))
	})
	rt.register_func('insert_hooked_blocks_into_rest_response', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return insert_hooked_blocks_into_rest_response(arg_0, arg_1)
	})
	rt.register_func('make_before_block_visitor', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return make_before_block_visitor(arg_0, arg_1, arg_2)
	})
	rt.register_func('make_after_block_visitor', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return make_after_block_visitor(arg_0, arg_1, arg_2)
	})
	rt.register_func('serialize_block_attributes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_block_attributes(arg_0)
	})
	rt.register_func('strip_core_block_namespace', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return strip_core_block_namespace(arg_0)
	})
	rt.register_func('get_comment_delimited_block_content', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return get_comment_delimited_block_content(arg_0, arg_1, arg_2)
	})
	rt.register_func('serialize_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_block(arg_0)
	})
	rt.register_func('serialize_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return serialize_blocks(arg_0)
	})
	rt.register_func('traverse_and_serialize_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return traverse_and_serialize_block(arg_0, arg_1, arg_2)
	})
	rt.register_func('resolve_pattern_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return resolve_pattern_blocks(arg_0)
	})
	rt.register_func('traverse_and_serialize_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_string(traverse_and_serialize_blocks(arg_0, arg_1, arg_2))
	})
	rt.register_func('filter_block_content', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_string(filter_block_content(arg_0, arg_1, arg_2))
	})
	rt.register_func('_filter_block_content_callback', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_filter_block_content_callback(arg_0))
	})
	rt.register_func('filter_block_kses', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return filter_block_kses(arg_0, arg_1, arg_2)
	})
	rt.register_func('filter_block_kses_value', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return filter_block_kses_value(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('filter_block_core_template_part_attributes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return filter_block_core_template_part_attributes(arg_0, arg_1, arg_2)
	})
	rt.register_func('excerpt_remove_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(excerpt_remove_blocks(arg_0))
	})
	rt.register_func('excerpt_remove_footnotes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return excerpt_remove_footnotes(arg_0)
	})
	rt.register_func('_excerpt_render_inner_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(_excerpt_render_inner_blocks(arg_0, arg_1))
	})
	rt.register_func('render_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return render_block(arg_0)
	})
	rt.register_func('parse_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return parse_blocks(arg_0)
	})
	rt.register_func('do_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(do_blocks(arg_0))
	})
	rt.register_func('_restore_wpautop_hook', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _restore_wpautop_hook(arg_0)
	})
	rt.register_func('block_version', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_int(block_version(arg_0))
	})
	rt.register_func('register_block_style', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return register_block_style(arg_0, arg_1)
	})
	rt.register_func('unregister_block_style', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return unregister_block_style(arg_0, arg_1)
	})
	rt.register_func('block_has_support', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
		return rt.new_bool(block_has_support(arg_0, arg_1, arg_2))
	})
	rt.register_func('wp_migrate_old_typography_shape', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return wp_migrate_old_typography_shape(arg_0)
	})
	rt.register_func('build_query_vars_from_query_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return build_query_vars_from_query_block(arg_0, arg_1)
	})
	rt.register_func('get_query_pagination_arrow', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return get_query_pagination_arrow(arg_0, arg_1)
	})
	rt.register_func('build_comment_query_vars_from_block', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return build_comment_query_vars_from_block(arg_0)
	})
	rt.register_func('get_comments_pagination_arrow', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return get_comments_pagination_arrow(arg_0, arg_1)
	})
	rt.register_func('_wp_filter_post_meta_footnotes', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(_wp_filter_post_meta_footnotes(arg_0))
	})
	rt.register_func('_wp_footnotes_kses_init_filters', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_kses_init_filters()
	})
	rt.register_func('_wp_footnotes_remove_filters', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_remove_filters()
	})
	rt.register_func('_wp_footnotes_kses_init', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_footnotes_kses_init()
	})
	rt.register_func('_wp_footnotes_force_filtered_html_on_import_filter', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _wp_footnotes_force_filtered_html_on_import_filter(arg_0)
	})
	rt.register_func('_wp_enqueue_auto_register_blocks', fn (args []rt.PhpVal) rt.PhpVal {
		return _wp_enqueue_auto_register_blocks()
	})
	rt.register_class_factory('WP_Block_Metadata_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_metadata_registry()
		return rt.new_object('WP_Block_Metadata_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Type_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_type_registry()
		return rt.new_object('WP_Block_Type_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Post', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_post()
		return rt.new_object('WP_Post', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Patterns_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_patterns_registry()
		return rt.new_object('WP_Block_Patterns_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Block', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block()
		return rt.new_object('WP_Block', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Styles_Registry', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_styles_registry()
		return rt.new_object('WP_Block_Styles_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Comment_Query', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_comment_query()
		return rt.new_object('WP_Comment_Query', []string{}, obj)
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
