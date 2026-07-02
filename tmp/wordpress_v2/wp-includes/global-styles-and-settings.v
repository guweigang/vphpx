import rt
import crypto.md5

fn wp_get_global_settings(var_path_arg rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_path := var_path_arg
	mut var_new_path := []rt.PhpVal{}
	mut var_subpath := rt.new_null()
	mut var_origin := ''
	mut var_cache_group := ''
	mut var_cache_key := rt.new_null()
	mut var_can_use_cached := false
	mut var_settings := rt.new_null()
	if !(!rt.is_true(var_context.array_get(rt.new_string('block_name')))) {
		var_new_path = [rt.new_string('blocks'), var_context.array_get(rt.new_string('block_name'))]
		mut iter_1 := var_path.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_subpath_shadow := item_1.val
			var_new_path << var_subpath_shadow.clone()
		}
		var_path = var_new_path.clone()
	}
	var_origin = 'custom'
	if var_context.array_isset(rt.new_string('origin'))
		&& rt.is_true(rt.identical(rt.new_string('base'), var_context.array_get(rt.new_string('origin')))) {
		var_origin = 'theme'
	}
	var_cache_group = 'theme_json'
	var_cache_key = rt.new_string('wp_get_global_settings_' + var_origin)
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	])))
	var_settings = rt.new_bool(false)
	if var_can_use_cached {
		var_settings = rt.call_function('wp_cache_get', [var_cache_key.clone(),
			rt.new_string(var_cache_group.str()).clone()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_settings)) {
		mut iife_temp_0 := Class_WP_Theme_JSON_Resolver{}
		mut iife_result_0 := iife_temp_0.get_merged_data(rt.new_string(var_origin.str()))
		var_settings = rt.call_method(iife_result_0, 'get_settings', []rt.PhpVal{})
		if var_can_use_cached {
			rt.call_function('wp_cache_set', [var_cache_key.clone(),
				var_settings.clone(), rt.new_string(var_cache_group.str()).clone()])
		}
	}
	return rt.call_function('_wp_array_get', [var_settings.clone(),
		var_path.clone(), var_settings.clone()])
}

fn wp_get_global_styles(var_path_arg rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_path := var_path_arg
	mut var_origin := ''
	mut var_resolve_variables := false
	mut var_merged_data := rt.new_null()
	mut var_styles := rt.new_null()
	if !(!rt.is_true(var_context.array_get(rt.new_string('block_name')))) {
		var_path = rt.call_function('array_merge', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' },
				rt.ArrayItem{ key: none, val: var_context.array_get(rt.new_string('block_name')) }]),
			var_path.clone(),
		])
	}
	var_origin = 'custom'
	if var_context.array_isset(rt.new_string('origin'))
		&& rt.is_true(rt.identical(rt.new_string('base'), var_context.array_get(rt.new_string('origin')))) {
		var_origin = 'theme'
	}
	var_resolve_variables = var_context.array_isset(rt.new_string('transforms'))
		&& var_context.array_get(rt.new_string('transforms')).is_array()
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('resolve-variables'), var_context.array_get(rt.new_string('transforms')), rt.new_bool(true)]))
	mut iife_temp_1 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_1 := iife_temp_1.get_merged_data(rt.new_string(var_origin.str()))
	var_merged_data = iife_result_1
	if var_resolve_variables {
		mut iife_temp_2 := Class_WP_Theme_JSON{}
		mut iife_result_2 := iife_temp_2.resolve_variables(var_merged_data.clone())
		var_merged_data = iife_result_2
	}
	var_styles =
		rt.call_method(var_merged_data, 'get_raw_data', []rt.PhpVal{}).array_get(rt.new_string('styles'))
	return rt.call_function('_wp_array_get', [var_styles.clone(),
		var_path.clone(), var_styles.clone()])
}

fn wp_get_global_stylesheet(var_types_arg rt.PhpVal) rt.PhpVal {
	mut var_types := var_types_arg
	mut var_can_use_cached := false
	mut var_cache_group := ''
	mut var_cache_key := ''
	mut var_cached := rt.new_null()
	mut var_tree := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_styles_variables := rt.new_null()
	mut var_origins := []rt.PhpVal{}
	mut var_styles_rest := rt.new_null()
	mut var_stylesheet := rt.new_null()
	var_can_use_cached = !rt.is_true(var_types)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')])))))
	var_cache_group = 'theme_json'
	var_cache_key = 'wp_get_global_stylesheet'
	if var_can_use_cached {
		var_cached = rt.call_function('wp_cache_get', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string(var_cache_group.str()).clone()])
		if rt.is_true(var_cached) {
			return var_cached.clone()
		}
	}
	mut iife_temp_3 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_3 := iife_temp_3.get_merged_data()
	mut iife_temp_4 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_4 := iife_temp_4.resolve_theme_file_uris(iife_result_3)
	var_tree = iife_result_4
	if !rt.is_true(var_types) {
		var_types = rt.create_array([rt.ArrayItem{ key: none, val: 'variables' },
			rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'presets' }])
	}
	var_options = map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(wp_theme_has_theme_json())))) {
		var_options['base_layout_styles'] = true
	}
	var_styles_variables = rt.new_string('')
	if rt.is_true(rt.call_function('in_array', [rt.new_string('variables'),
		var_types.clone(), rt.new_bool(true)]))
	{
		var_origins = ['default', 'theme', 'custom']
		var_styles_variables = rt.call_method(var_tree, 'get_stylesheet', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }]),
			rt.create_array_from_list(var_origins),
			rt.create_array_from_native_map(var_options),
		])
		var_types = rt.call_function('array_diff', [var_types.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }])])
	}
	var_styles_rest = rt.new_string('')
	if !(!rt.is_true(var_types)) {
		var_origins = ['default', 'theme', 'custom']
		var_styles_rest = rt.call_method(var_tree, 'get_stylesheet', [
			var_types.clone(), rt.create_array_from_list(var_origins),
			rt.create_array_from_native_map(var_options)])
	}
	var_stylesheet = rt.new_string(var_styles_variables.str() + var_styles_rest.str())
	if var_can_use_cached {
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
			var_stylesheet.clone(), rt.new_string(var_cache_group.str()).clone()])
	}
	return var_stylesheet.clone()
}

fn wp_add_global_styles_for_blocks() {
	mut var_wp_styles := rt.new_null()
	mut var_tree := rt.new_null()
	mut var_block_nodes := rt.new_null()
	mut var_can_use_cached := false
	mut var_update_cache := false
	mut var_cache_hash := ''
	mut var_cache_key := ''
	mut var_cached := rt.new_null()
	mut var_metadata := rt.new_null()
	mut var_cache_node_key := ''
	mut var_block_css := rt.new_null()
	mut var_stylesheet_handle := ''
	mut var_block_name := rt.new_null()
	mut var_block_handle := rt.new_null()
	mut iife_temp_5 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_5 := iife_temp_5.get_merged_data()
	var_tree = iife_result_5
	mut iife_temp_6 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_6 := iife_temp_6.resolve_theme_file_uris(var_tree.clone())
	var_tree = iife_result_6
	var_block_nodes = rt.call_method(var_tree, 'get_styles_block_nodes', []rt.PhpVal{})
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	])))
	var_update_cache = false
	if var_can_use_cached {
		var_cache_hash = md5.hexhash(rt.call_function('wp_json_encode', [
			rt.call_method(var_tree, 'get_raw_data', []rt.PhpVal{}),
		]).to_string())
		var_cache_key = 'wp_styles_for_blocks'
		var_cached = rt.call_function('get_transient', [rt.new_string(var_cache_key.str()).clone()])
		if !(var_cached.clone().is_array())
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_cached.array_get(rt.new_string('hash')), rt.new_string(var_cache_hash.str()))))) {
			var_cached = rt.create_array([
				rt.ArrayItem{ key: 'hash', val: var_cache_hash },
				rt.ArrayItem{
					key: 'blocks'
					val: map[string]rt.PhpVal{}
				},
			])
			var_update_cache = true
		}
	}
	mut iter_2 := var_block_nodes.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_metadata_shadow := item_2.val
		if var_can_use_cached {
			var_cache_node_key = md5.hexhash(rt.call_function('wp_json_encode', [
				var_metadata_shadow.clone(),
			]).to_string())
			if var_cached.array_get(rt.new_string('blocks')).array_isset(rt.new_string(var_cache_node_key.str())) {
				var_block_css =
					var_cached.array_get(rt.new_string('blocks')).array_get(rt.new_string(var_cache_node_key.str()))
			} else {
				var_block_css = rt.call_method(var_tree, 'get_styles_for_block', [
					var_metadata_shadow.clone(),
				])
				var_cached.array_get_mut('blocks').array_set(var_cache_node_key,
					var_block_css.clone())
				var_update_cache = true
			}
		} else {
			var_block_css = rt.call_method(var_tree, 'get_styles_for_block', [
				var_metadata_shadow.clone()])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_block_assets_on_demand',
			[]rt.PhpVal{})))))
		{
			rt.call_function('wp_add_inline_style', [rt.new_string('global-styles'),
				var_block_css.clone()])
			continue
		}
		var_stylesheet_handle = 'global-styles'
		if var_metadata_shadow.array_isset(rt.new_string('name')) {
			if rt.is_true(rt.call_function('str_starts_with', [
				var_metadata_shadow.array_get(rt.new_string('name')),
				rt.new_string('core/'),
			]))
			{
				var_block_name = rt.call_function('str_replace', [
					rt.new_string('core/'), rt.new_string(''),
					var_metadata_shadow.array_get(rt.new_string('name'))])
				var_block_handle = rt.new_string('wp-block-' + var_block_name.str())
				if rt.is_true(rt.call_function('in_array', [var_block_handle.clone(),
					rt.get_property(var_wp_styles, 'queue'), rt.new_bool(true)]))
				{
					rt.call_function('wp_add_inline_style', [
						rt.new_string(var_stylesheet_handle.str()).clone(),
						var_block_css.clone()])
				}
			} else {
				rt.call_function('wp_add_inline_style', [rt.new_string(var_stylesheet_handle.str()).clone(),
					var_block_css.clone()])
			}
		}
		if !(var_metadata_shadow.array_isset(rt.new_string('name')))
			&& !(!rt.is_true(var_metadata_shadow.array_get(rt.new_string('path')))) {
			var_block_name =
				wp_get_block_name_from_theme_json_path(var_metadata_shadow.array_get(rt.new_string('path')))
			if rt.is_true(var_block_name) {
				if rt.is_true(rt.call_function('str_starts_with', [
					var_block_name.clone(), rt.new_string('core/')]))
				{
					var_block_name = rt.call_function('str_replace', [
						rt.new_string('core/'),
						rt.new_string(''),
						var_block_name.clone(),
					])
					var_block_handle = rt.new_string('wp-block-' + var_block_name.str())
					if rt.is_true(rt.call_function('in_array', [
						var_block_handle.clone(), rt.get_property(var_wp_styles, 'queue'),
						rt.new_bool(true)]))
					{
						rt.call_function('wp_add_inline_style', [
							rt.new_string(var_stylesheet_handle.str()).clone(),
							var_block_css.clone()])
					}
				} else {
					rt.call_function('wp_add_inline_style', [
						rt.new_string(var_stylesheet_handle.str()).clone(),
						var_block_css.clone()])
				}
			}
		}
	}
	if var_update_cache {
		rt.call_function('set_transient', [rt.new_string(var_cache_key.str()).clone(),
			var_cached.clone()])
	}
}

fn wp_get_block_name_from_theme_json_path(var_path rt.PhpVal) rt.PhpVal {
	mut var_result := rt.new_null()
	if var_path.clone().array_count() >= 3
		&& rt.is_true(rt.identical(rt.new_string('styles'), var_path.array_get(rt.new_int(0))))
		&& rt.is_true(rt.identical(rt.new_string('blocks'), var_path.array_get(rt.new_int(1))))
		&& rt.is_true(rt.call_function('str_contains', [var_path.array_get(rt.new_int(2)), rt.new_string('/')])) {
		return var_path.array_get(rt.new_int(2))
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_function('str_contains', [var_item.clone(),
			rt.new_string('core/')]))
		{
			return rt.new_bool(true)
		}
		return rt.new_bool(false)
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.call_function('str_contains', [var_item.clone(),
			rt.new_string('core/')]))
		{
			return rt.new_bool(true)
		}
		return rt.new_bool(false)
	}
	var_result = rt.call_function('array_values', [
		rt.call_function('array_filter', [var_path.clone(), rt.new_closure(closure_8_fn)]),
	])
	return if !(var_result.array_get(rt.new_int(0))).is_null() {
		var_result.array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
}

fn wp_theme_has_theme_json() rt.PhpVal {
	mut var_theme_has_support := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_stylesheet_directory := rt.new_null()
	mut var_template_directory := rt.new_null()
	mut var_path := rt.new_null()
	var_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
	if var_theme_has_support.array_isset(var_stylesheet)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')]))))) {
		return var_theme_has_support.array_get(var_stylesheet)
	}
	var_stylesheet_directory = rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	var_template_directory = rt.call_function('get_template_directory', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_stylesheet_directory, var_template_directory))))
		&& rt.is_true(rt.call_function('file_exists', [rt.new_string(var_stylesheet_directory.str() + '/theme.json')])) {
		var_path = rt.new_string(var_stylesheet_directory.str() + '/theme.json')
	} else {
		var_path = rt.new_string(var_template_directory.str() + '/theme.json')
	}
	var_path = rt.call_function('apply_filters', [rt.new_string('theme_file_path'),
		var_path.clone(), rt.new_string('theme.json')])
	var_theme_has_support.array_set(var_stylesheet, rt.call_function('file_exists', [
		var_path.clone(),
	]))
	return var_theme_has_support.array_get(var_stylesheet)
}

fn wp_clean_theme_json_cache() {
	rt.call_function('wp_cache_delete', [rt.new_string('wp_get_global_stylesheet'),
		rt.new_string('theme_json')])
	rt.call_function('wp_cache_delete', [
		rt.new_string('wp_get_global_styles_svg_filters'),
		rt.new_string('theme_json'),
	])
	rt.call_function('wp_cache_delete', [rt.new_string('wp_get_global_settings_custom'),
		rt.new_string('theme_json')])
	rt.call_function('wp_cache_delete', [rt.new_string('wp_get_global_settings_theme'),
		rt.new_string('theme_json')])
	rt.call_function('wp_cache_delete', [
		rt.new_string('wp_get_global_styles_custom_css'),
		rt.new_string('theme_json'),
	])
	rt.call_function('wp_cache_delete', [
		rt.new_string('wp_get_theme_data_template_parts'),
		rt.new_string('theme_json'),
	])
	mut iife_temp_9 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_9 := iife_temp_9.clean_cached_data()
}

fn wp_get_theme_directory_pattern_slugs() rt.PhpVal {
	mut iife_temp_10 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_10 := iife_temp_10.get_theme_data(map[string]rt.PhpVal{}, rt.create_array([
		rt.ArrayItem{ key: 'with_supports', val: false },
	]))
	return rt.call_method(iife_result_10, 'get_patterns', []rt.PhpVal{})
}

fn wp_get_theme_data_custom_templates() rt.PhpVal {
	mut iife_temp_11 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_11 := iife_temp_11.get_theme_data(map[string]rt.PhpVal{}, rt.create_array([
		rt.ArrayItem{ key: 'with_supports', val: false },
	]))
	return rt.call_method(iife_result_11, 'get_custom_templates', []rt.PhpVal{})
}

fn wp_get_theme_data_template_parts() rt.PhpVal {
	mut var_cache_group := ''
	mut var_cache_key := ''
	mut var_can_use_cached := false
	mut var_metadata := rt.new_null()
	var_cache_group = 'theme_json'
	var_cache_key = 'wp_get_theme_data_template_parts'
	var_can_use_cached = !(rt.is_true(rt.call_function('wp_is_development_mode', [
		rt.new_string('theme'),
	])))
	if var_can_use_cached {
		var_metadata = rt.call_function('wp_cache_get', [rt.new_string(var_cache_key.str()).clone(),
			rt.new_string(var_cache_group.str()).clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_metadata)))) {
			return var_metadata.clone()
		}
	}
	mut iife_temp_12 := Class_WP_Theme_JSON_Resolver{}
	mut iife_result_12 := iife_temp_12.get_theme_data(map[string]rt.PhpVal{}, rt.create_array([
		rt.ArrayItem{ key: 'with_supports', val: false },
	]))
	var_metadata = rt.call_method(iife_result_12, 'get_template_parts', []rt.PhpVal{})
	if var_can_use_cached {
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key.str()).clone(),
			var_metadata.clone(), rt.new_string(var_cache_group.str()).clone()])
	}
	return var_metadata.clone()
}

fn wp_get_block_css_selector(var_block_type rt.PhpVal, target string, fallback bool) rt.PhpVal {
	mut var_target := target
	mut var_fallback := fallback
	mut var_has_selectors := false
	mut var_root_selector := rt.new_null()
	mut var_block_name := rt.new_null()
	mut var_fallback_selector := rt.new_null()
	mut var_path := rt.new_null()
	mut var_feature_selector := rt.new_null()
	mut var_subfeature_selector := rt.new_null()
	if var_target == '' {
		return rt.new_null()
	}
	var_has_selectors = !(!rt.is_true(rt.get_property(var_block_type, 'selectors')))
	var_root_selector = rt.new_null()
	if var_has_selectors
		&& rt.get_property(var_block_type, 'selectors').array_isset(rt.new_string('root')) {
		var_root_selector =
			rt.get_property(var_block_type, 'selectors').array_get(rt.new_string('root'))
	} else if
		rt.get_property(var_block_type, 'supports').array_isset(rt.new_string('__experimentalSelector'))
		&& rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalSelector')).is_string() {
		var_root_selector =
			rt.get_property(var_block_type, 'supports').array_get(rt.new_string('__experimentalSelector'))
	} else {
		var_block_name = rt.call_function('str_replace', [rt.new_string('/'),
			rt.new_string('-'),
			rt.call_function('str_replace', [
				rt.new_string('core/'), rt.new_string(''), rt.get_property(var_block_type, 'name')])])
		var_root_selector = rt.new_string('.wp-block-${var_block_name.to_string()}')
	}
	if rt.is_true(rt.identical(rt.new_string('root'), rt.new_string(var_target.str()))) {
		return var_root_selector.clone()
	}
	if rt.is_true(rt.new_bool(rt.new_string(var_target.str()).is_string())) {
		var_target = (rt.call_function('explode', [rt.new_string('.'),
			rt.new_string(var_target.str())])).str()
	}
	if 1 == rt.new_string(var_target.str()).array_count() {
		var_fallback_selector = if var_fallback { var_root_selector } else { rt.new_null() }
		if var_has_selectors {
			var_path = rt.create_array([
				rt.ArrayItem{ key: none, val: rt.call_function('current', [
					rt.new_string(var_target.str()),
				]) },
				rt.ArrayItem{ key: none, val: 'root' },
			])
			var_feature_selector = rt.call_function('_wp_array_get', [
				rt.get_property(var_block_type, 'selectors'),
				var_path.clone(),
				rt.new_null(),
			])
			if rt.is_true(var_feature_selector) {
				return var_feature_selector.clone()
			}
			var_feature_selector = rt.call_function('_wp_array_get', [
				rt.get_property(var_block_type, 'selectors'),
				rt.new_string(var_target.str()),
				rt.new_null(),
			])
			return if var_feature_selector.clone().is_string() {
				var_feature_selector
			} else {
				var_fallback_selector
			}
		}
		var_path = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.call_function('current', [
				rt.new_string(var_target.str()),
			]) },
			rt.ArrayItem{ key: none, val: '__experimentalSelector' },
		])
		var_feature_selector = rt.call_function('_wp_array_get', [
			rt.get_property(var_block_type, 'supports'),
			var_path.clone(),
			rt.new_null(),
		])
		if rt.is_true(rt.identical(rt.new_null(), var_feature_selector)) {
			return var_fallback_selector.clone()
		}
		mut iife_temp_13 := Class_WP_Theme_JSON{}
		mut iife_result_13 := iife_temp_13.scope_selector(var_root_selector.clone(),
			var_feature_selector.clone())
		return iife_result_13
	}
	var_subfeature_selector = rt.new_null()
	if var_has_selectors {
		var_subfeature_selector = rt.call_function('_wp_array_get', [
			rt.get_property(var_block_type, 'selectors'),
			rt.new_string(var_target.str()),
			rt.new_null(),
		])
	}
	if rt.is_true(var_subfeature_selector) {
		return var_subfeature_selector.clone()
	}
	if var_fallback {
		return wp_get_block_css_selector(var_block_type.clone(),
			rt.new_string(var_target.str()).array_get(rt.new_int(0)), fallback)
	}
	return rt.new_null()
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json(_args ...rt.PhpVal) &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
