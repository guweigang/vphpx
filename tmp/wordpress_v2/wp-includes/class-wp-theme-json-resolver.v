import rt

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

fn init_static_wp_theme_json_resolver() {
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'blocks_cache', rt.create_array([
		rt.ArrayItem{ key: 'core', val: rt.new_array() },
		rt.ArrayItem{ key: 'blocks', val: rt.new_array() },
		rt.ArrayItem{ key: 'theme', val: rt.new_array() },
		rt.ArrayItem{ key: 'user', val: rt.new_array() },
	]))
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'core', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'blocks', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'theme', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'user', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'user_custom_post_type_id', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'i18n_schema', rt.new_null())
	rt.init_static_prop('WP_Theme_JSON_Resolver', 'theme_json_file_cache', rt.new_array())
}

fn Class_WP_Theme_JSON_Resolver.read_json_file(var_file_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_file_path) {
		if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Theme_JSON_Resolver',
			'theme_json_file_cache').array_isset(var_file_path.clone())))
		{
			return rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme_json_file_cache').array_get(var_file_path)
		}
		mut var_decoded_file := rt.call_function('wp_json_file_decode', [
			var_file_path.clone(), rt.create_array([
				rt.ArrayItem{ key: 'associative', val: true },
			])])
		if rt.is_true(rt.new_bool(var_decoded_file.clone().is_array())) {
			rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme_json_file_cache').array_set(var_file_path,
				var_decoded_file.clone())
			return rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme_json_file_cache').array_get(var_file_path)
		}
	}
	return rt.new_array()
}

fn Class_WP_Theme_JSON_Resolver.get_fields_to_translate() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('5.9.0')])
	return rt.new_array()
}

fn Class_WP_Theme_JSON_Resolver.translate(var_theme_json rt.PhpVal, domain string) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver',
		'i18n_schema')))
	{
		mut var_i18n_schema := rt.call_function('wp_json_file_decode', [
			rt.new_string(@DIR + '/theme-i18n.json'),
		])
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'i18n_schema', if !var_i18n_schema.is_null() {
			var_i18n_schema
		} else {
			rt.new_array()
		})
	}
	return rt.call_function('translate_settings_using_i18n_schema', [
		rt.get_static_prop('WP_Theme_JSON_Resolver', 'i18n_schema'),
		var_theme_json_mutated.clone(),
		rt.new_string(domain),
	])
}

fn Class_WP_Theme_JSON_Resolver.get_core_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver', 'core')))))
		&& rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('core'))) {
		return rt.get_static_prop('WP_Theme_JSON_Resolver', 'core')
	}
	mut var_config :=
		Class_WP_Theme_JSON_Resolver.read_json_file(rt.new_string(@DIR + '/theme.json'))
	var_config = Class_WP_Theme_JSON_Resolver.translate(var_config.str())
	mut var_theme_json := rt.call_function('apply_filters', [
		rt.new_string('wp_theme_json_data_default'),
		create_wp_theme_json_data(var_config.clone(), rt.new_string('default')),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'core', rt.call_method(var_theme_json,
			'get_theme_json', []rt.PhpVal{}))
	} else {
		var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'core', rt.new_object('WP_Theme_JSON',
			[]string{}, create_wp_theme_json(var_config.clone(), rt.new_string('default'))))
	}
	return rt.get_static_prop('WP_Theme_JSON_Resolver', 'core')
}

fn Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(var_origin rt.PhpVal) bool {
	if !(rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks_cache').array_isset(var_origin)) {
		return false
	}
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_registry := iife_result_0
	mut var_blocks := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	mut var_block_diff := rt.call_function('array_diff_key', [
		var_blocks.clone(), rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks_cache').array_get(var_origin)])
	if !rt.is_true(var_block_diff) {
		return true
	}
	mut iter_1 := var_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_type := item_1.val
		mut var_block_name := item_1.key
		rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks_cache').array_get_mut(var_origin).array_set(var_block_name,
			true)
	}
	return false
}

fn Class_WP_Theme_JSON_Resolver.get_theme_data(var_deprecated rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@METHOD),
			rt.new_string('5.9.0')])
	}
	var_options_mutated = rt.call_function('wp_parse_args', [
		var_options_mutated.clone(), rt.create_array([
			rt.ArrayItem{ key: 'with_supports', val: true },
		])])
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('theme')))))) {
		mut var_wp_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		mut var_theme_json_file := rt.call_method(var_wp_theme, 'get_file_path', [
			rt.new_string('theme.json'),
		])
		if rt.is_true(rt.call_function('is_readable', [var_theme_json_file.clone()])) {
			mut var_theme_json_data :=
				Class_WP_Theme_JSON_Resolver.read_json_file(var_theme_json_file.clone())
			var_theme_json_data = Class_WP_Theme_JSON_Resolver.translate(var_theme_json_data.str(), rt.call_method(var_wp_theme,
				'get', [rt.new_string('TextDomain')]))
		} else {
			var_theme_json_data = rt.create_array([
				rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() },
			])
		}
		mut var_variations := Class_WP_Theme_JSON_Resolver.get_style_variations('block')
		rt.call_function('wp_register_block_style_variations_from_theme_json_partials', [
			var_variations.clone(),
		])
		var_theme_json_data = Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(var_theme_json_data.clone(),
			var_variations.clone())
		var_theme_json_data =
			Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(var_theme_json_data.clone())
		mut var_theme_json := rt.call_function('apply_filters', [
			rt.new_string('wp_theme_json_data_theme'),
			create_wp_theme_json_data(var_theme_json_data.clone(), rt.new_string('theme')),
		])
		if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
			rt.set_static_prop('WP_Theme_JSON_Resolver', 'theme', rt.call_method(var_theme_json,
				'get_theme_json', []rt.PhpVal{}))
		} else {
			mut var_config := rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
			rt.set_static_prop('WP_Theme_JSON_Resolver', 'theme', rt.new_object('WP_Theme_JSON',
				[]string{}, create_wp_theme_json(var_config.clone())))
		}
		if rt.is_true(rt.call_method(var_wp_theme, 'parent', []rt.PhpVal{})) {
			mut var_parent_theme_json_file := rt.call_method(rt.call_method(var_wp_theme, 'parent',
				[]rt.PhpVal{}), 'get_file_path', [rt.new_string('theme.json')])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_theme_json_file, var_parent_theme_json_file))))
				&& rt.is_true(rt.call_function('is_readable', [var_parent_theme_json_file.clone()])) {
				mut var_parent_theme_json_data :=
					Class_WP_Theme_JSON_Resolver.read_json_file(var_parent_theme_json_file.clone())
				var_parent_theme_json_data = Class_WP_Theme_JSON_Resolver.translate(var_parent_theme_json_data.str(), rt.call_method(rt.call_method(var_wp_theme,
					'parent', []rt.PhpVal{}), 'get', [rt.new_string('TextDomain')]))
				mut var_parent_theme := create_wp_theme_json(var_parent_theme_json_data.clone())
				var_parent_theme.merge(rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme'))
				rt.set_static_prop('WP_Theme_JSON_Resolver', 'theme', var_parent_theme)
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('with_supports')))))) {
		return mut rt.cast_object_ptr[Class_WP_Theme_JSON](rt.get_static_prop('WP_Theme_JSON_Resolver',
			'theme'))
	}
	mut iife_temp_1 := Class_WP_Theme_JSON{}
	mut iife_result_1 := iife_temp_1.get_from_editor_settings(rt.call_function('get_classic_theme_supports_block_editor_settings',
		[]rt.PhpVal{}))
	mut var_theme_support_data := iife_result_1
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json',
		[]rt.PhpVal{})))))
	{
		var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('defaultPalette',
			!(var_theme_support_data.array_get(rt.new_string('settings')).array_get(rt.new_string('color')).array_isset(rt.new_string('palette')))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-color-palette')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('defaultGradients',
			!(var_theme_support_data.array_get(rt.new_string('settings')).array_get(rt.new_string('color')).array_isset(rt.new_string('gradients')))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-gradient-presets')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('typography').array_set('defaultFontSizes',
			!(var_theme_support_data.array_get(rt.new_string('settings')).array_get(rt.new_string('typography')).array_isset(rt.new_string('fontSizes')))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-font-sizes')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('spacing').array_set('defaultSpacingSizes',
			!(var_theme_support_data.array_get(rt.new_string('settings')).array_get(rt.new_string('spacing')).array_isset(rt.new_string('spacingSizes')))
			|| rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-spacing-sizes')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('shadow').array_set('defaultPresets',
			false)
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('link-color'),
		]))
		{
			var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('link',
				true)
		}
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('border'),
		]))
		{
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('color',
				true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('radius',
				true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('style',
				true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('width',
				true)
		}
		if rt.is_true(rt.call_function('current_theme_supports', [
			rt.new_string('appearance-tools'),
		]))
		{
			var_theme_support_data.array_get_mut('settings').array_set('appearanceTools', true)
		}
	}
	mut var_with_theme_supports := create_wp_theme_json(var_theme_support_data.clone())
	var_with_theme_supports.merge(rt.get_static_prop('WP_Theme_JSON_Resolver', 'theme'))
	return mut var_with_theme_supports
}

fn Class_WP_Theme_JSON_Resolver.get_block_data() rt.PhpVal {
	mut iife_temp_2 := Class_WP_Block_Type_Registry{}
	mut iife_result_2 := iife_temp_2.get_instance()
	mut var_registry := iife_result_2
	mut var_blocks := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks')))))
		&& rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('blocks'))) {
		return rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks')
	}
	mut var_config := rt.create_array([
		rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() },
	])
	mut iter_2 := var_blocks.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_block_type := item_2.val
		mut var_block_name := item_2.key
		if rt.get_property(var_block_type, 'supports').array_isset(rt.new_string('__experimentalStyle')) {
			var_config.array_get_mut('styles').array_get_mut('blocks').array_set(var_block_name, Class_WP_Theme_JSON_Resolver.remove_json_comments(rt.get_property(var_block_type,
				'supports').array_get(rt.new_string('__experimentalStyle'))))
		}
		if rt.get_property(var_block_type, 'supports').array_get(rt.new_string('spacing')).array_get(rt.new_string('blockGap')).array_isset(rt.new_string('__experimentalDefault'))
			&& !(var_config.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).array_get(var_block_name).array_get(rt.new_string('spacing')).array_isset(rt.new_string('blockGap'))) {
			var_config.array_get_mut('styles').array_get_mut('blocks').array_get_mut(var_block_name).array_get_mut('spacing').array_set('blockGap',
				rt.new_null())
		}
	}
	mut var_theme_json := rt.call_function('apply_filters', [
		rt.new_string('wp_theme_json_data_blocks'),
		create_wp_theme_json_data(var_config.clone(), rt.new_string('blocks')),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'blocks', rt.call_method(var_theme_json,
			'get_theme_json', []rt.PhpVal{}))
	} else {
		var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'blocks', rt.new_object('WP_Theme_JSON',
			[]string{}, create_wp_theme_json(var_config.clone(), rt.new_string('blocks'))))
	}
	return rt.get_static_prop('WP_Theme_JSON_Resolver', 'blocks')
}

fn Class_WP_Theme_JSON_Resolver.remove_json_comments(var_input_array rt.PhpVal) rt.PhpVal {
	mut var_input_array_mutated := var_input_array
	var_input_array_mutated.array_unset(rt.new_string('//'))
	mut iter_3 := var_input_array_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_v := item_3.val
		mut var_k := item_3.key
		if rt.is_true(rt.new_bool(var_v.clone().is_array())) {
			var_input_array_mutated.array_set(var_k,
				Class_WP_Theme_JSON_Resolver.remove_json_comments(var_v.clone()))
		}
	}
	return var_input_array_mutated.clone()
}

fn Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles(var_theme rt.PhpVal, create_post bool, var_post_status_filter rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theme_mutated, 'WP_Theme')))))) {
		var_theme_mutated = rt.call_function('wp_get_theme', []rt.PhpVal{})
	}
	mut var_user_cpt := rt.new_array()
	mut var_post_type_filter := rt.new_string('wp_global_styles')
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	mut var_args := {
		'posts_per_page':         rt.new_int(1)
		'orderby':                rt.new_string('date')
		'order':                  rt.new_string('desc')
		'post_type':              var_post_type_filter
		'post_status':            var_post_status_filter
		'ignore_sticky_posts':    rt.new_bool(true)
		'no_found_rows':          rt.new_bool(true)
		'update_post_meta_cache': rt.new_bool(false)
		'update_post_term_cache': rt.new_bool(false)
		'tax_query':              map[string]rt.PhpVal{}
	}
	mut var_global_style_query := create_wp_query()
	mut var_recent_posts := var_global_style_query.query(var_args.clone())
	if var_recent_posts.clone().array_count() == 1
		&& rt.is_true(rt.new_bool(rt.instance_of(var_recent_posts.array_get(rt.new_int(0)), 'WP_Post'))) {
		var_user_cpt = rt.call_function('get_object_vars',
			[var_recent_posts.array_get(rt.new_int(0))])
	} else if var_create_post {
		mut var_cpt_post_id := rt.call_function('wp_insert_post', [
			rt.create_array([
				rt.ArrayItem{
					key: 'post_content'
					val: '{"version": ' +
						(Class_WP_Theme_JSON.latest_schema()).str() + ', "isGlobalStylesUserThemeJSON": true }'
				},
				rt.ArrayItem{ key: 'post_status', val: 'publish' },
				rt.ArrayItem{ key: 'post_title', val: 'Custom Styles' },
				rt.ArrayItem{ key: 'post_type', val: var_post_type_filter },
				rt.ArrayItem{ key: 'post_name', val: rt.call_function('sprintf', [
					rt.new_string('wp-global-styles-%s'),
					rt.call_function('urlencode', [var_stylesheet.clone()]),
				]) },
				rt.ArrayItem{ key: 'tax_input', val: rt.create_array([
					rt.ArrayItem{ key: 'wp_theme', val: rt.create_array([
						rt.ArrayItem{ key: none, val: var_stylesheet }]) },
				]) },
			]),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_cpt_post_id.clone(),
		])))))
		{
			mut var_post := rt.call_function('get_post', [var_cpt_post_id.clone()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
				var_user_cpt = rt.call_function('get_object_vars', [
					var_post.clone()])
			}
		}
	}
	return var_user_cpt.clone()
}

fn Class_WP_Theme_JSON_Resolver.get_user_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver', 'user')))))
		&& rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('user'))) {
		return rt.get_static_prop('WP_Theme_JSON_Resolver', 'user')
	}
	mut var_config := rt.new_array()
	mut var_user_cpt := Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles((rt.call_function('wp_get_theme',
		[]rt.PhpVal{})).to_bool())
	if rt.is_true(rt.new_bool(var_user_cpt.clone().array_isset(rt.new_string('post_content')))) {
		mut var_decoded_data := rt.call_function('json_decode', [
			var_user_cpt.array_get(rt.new_string('post_content')),
			rt.new_bool(true),
		])
		mut var_json_decoding_error := rt.call_function('json_last_error', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('JSON_ERROR_NONE'),
			var_json_decoding_error))))
		{
			rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
				rt.new_string('Error when decoding a theme.json schema for user data. ' +
					(rt.call_function('json_last_error_msg', []rt.PhpVal{})).str())])
			mut var_theme_json := rt.call_function('apply_filters', [
				rt.new_string('wp_theme_json_data_user'),
				create_wp_theme_json_data(var_config.clone(), rt.new_string('custom')),
			])
			if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
				return rt.call_method(var_theme_json, 'get_theme_json', []rt.PhpVal{})
			} else {
				var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
				return rt.new_object('WP_Theme_JSON', []string{}, create_wp_theme_json(var_config.clone(),
					rt.new_string('custom')))
			}
		}
		if var_decoded_data.clone().is_array()
			&& var_decoded_data.array_isset(rt.new_string('isGlobalStylesUserThemeJSON'))
			&& rt.is_true(var_decoded_data.array_get(rt.new_string('isGlobalStylesUserThemeJSON'))) {
			var_decoded_data.array_unset(rt.new_string('isGlobalStylesUserThemeJSON'))
			var_config = var_decoded_data.clone()
		}
	}
	var_theme_json = rt.call_function('apply_filters', [
		rt.new_string('wp_theme_json_data_user'),
		create_wp_theme_json_data(var_config.clone(), rt.new_string('custom')),
	])
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'user', rt.call_method(var_theme_json,
			'get_theme_json', []rt.PhpVal{}))
	} else {
		var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'user', rt.new_object('WP_Theme_JSON',
			[]string{}, create_wp_theme_json(var_config.clone(), rt.new_string('custom'))))
	}
	return rt.get_static_prop('WP_Theme_JSON_Resolver', 'user')
}

fn Class_WP_Theme_JSON_Resolver.get_merged_data(origin string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.new_string(origin).is_array())) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('5.9.0')])
	}
	mut var_result := create_wp_theme_json()
	var_result.merge(Class_WP_Theme_JSON_Resolver.get_core_data())
	if rt.is_true(rt.identical(rt.new_string('default'), rt.new_string(origin))) {
		return mut var_result
	}
	var_result.merge(Class_WP_Theme_JSON_Resolver.get_block_data())
	if rt.is_true(rt.identical(rt.new_string('blocks'), rt.new_string(origin))) {
		return mut var_result
	}
	var_result.merge(Class_WP_Theme_JSON_Resolver.get_theme_data())
	if rt.is_true(rt.identical(rt.new_string('theme'), rt.new_string(origin))) {
		return mut var_result
	}
	var_result.merge(Class_WP_Theme_JSON_Resolver.get_user_data())
	return mut var_result
}

fn Class_WP_Theme_JSON_Resolver.get_user_global_styles_post_id() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Theme_JSON_Resolver',
		'user_custom_post_type_id')))))
	{
		return rt.get_static_prop('WP_Theme_JSON_Resolver', 'user_custom_post_type_id')
	}
	mut var_user_cpt := Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles((rt.call_function('wp_get_theme',
		[]rt.PhpVal{})).to_bool(), rt.new_bool(true))
	if rt.is_true(rt.new_bool(var_user_cpt.clone().array_isset(rt.new_string('ID')))) {
		rt.set_static_prop('WP_Theme_JSON_Resolver', 'user_custom_post_type_id',
			var_user_cpt.array_get(rt.new_string('ID')))
	}
	return rt.get_static_prop('WP_Theme_JSON_Resolver', 'user_custom_post_type_id')
}

fn Class_WP_Theme_JSON_Resolver.theme_has_support() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.2.0'), rt.new_string('wp_theme_has_theme_json()')])
	return rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})
}

fn Class_WP_Theme_JSON_Resolver.get_file_path_from_theme(var_file_name rt.PhpVal, template bool) rt.PhpVal {
	mut var_path := if var_template {
		rt.call_function('get_template_directory', []rt.PhpVal{})
	} else {
		rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	}
	mut var_candidate := rt.new_string(var_path.str() + '/' + var_file_name.str())
	return if rt.is_true(rt.call_function('is_readable', [var_candidate.clone()])) {
		var_candidate
	} else {
		rt.new_string('')
	}
}

fn Class_WP_Theme_JSON_Resolver.clean_cached_data() {
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'core', rt.new_null())
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'blocks', rt.new_null())
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'blocks_cache', rt.create_array([
		rt.ArrayItem{ key: 'core', val: rt.new_array() },
		rt.ArrayItem{ key: 'blocks', val: rt.new_array() },
		rt.ArrayItem{ key: 'theme', val: rt.new_array() },
		rt.ArrayItem{ key: 'user', val: rt.new_array() },
	]))
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'theme', rt.new_null())
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'user', rt.new_null())
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'user_custom_post_type_id', rt.new_null())
	rt.set_static_prop('WP_Theme_JSON_Resolver', 'i18n_schema', rt.new_null())
}

fn Class_WP_Theme_JSON_Resolver.recursively_iterate_json(var_dir rt.PhpVal) rt.PhpVal {
	mut var_nested_files :=
		create_recursiveiteratoriterator(create_recursivedirectoryiterator(var_dir.clone()))
	mut var_nested_json_files := rt.call_function('iterator_to_array', [
		create_regexiterator(var_nested_files, rt.new_string('/^.+\\.json$/i'),
			Class_RecursiveRegexIterator.get_match()),
	])
	return var_nested_json_files.clone()
}

fn Class_WP_Theme_JSON_Resolver.style_variation_has_scope(var_variation rt.PhpVal, var_scope rt.PhpVal) bool {
	mut var_variation_mutated := var_variation
	if rt.is_true(rt.identical(rt.new_string('block'), var_scope)) {
		return (rt.new_bool(var_variation_mutated.array_isset(rt.new_string('blockTypes')))).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('theme'), var_scope)) {
		return !(var_variation_mutated.array_isset(rt.new_string('blockTypes')))
	}
	return false
}

fn Class_WP_Theme_JSON_Resolver.get_style_variations(scope string) rt.PhpVal {
	mut var_variation_files := rt.new_array()
	mut var_variations := rt.new_array()
	mut var_base_directory := rt.new_string(
		(rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/styles')
	mut var_template_directory := rt.new_string(
		(rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/styles')
	if rt.is_true(rt.call_function('is_dir', [var_base_directory.clone()])) {
		var_variation_files =
			Class_WP_Theme_JSON_Resolver.recursively_iterate_json(var_base_directory.clone())
	}
	if rt.is_true(rt.call_function('is_dir', [var_template_directory.clone()]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_template_directory, var_base_directory)))) {
		mut var_variation_files_parent :=
			Class_WP_Theme_JSON_Resolver.recursively_iterate_json(var_template_directory.clone())
		mut iter_4 := var_variation_files_parent.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_parent := item_4.val
			mut var_parent_path := item_4.key
			mut iter_5 := var_variation_files.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_child := item_5.val
				mut var_child_path := item_5.key
				if rt.is_true(rt.identical(rt.call_function('basename', [
					var_parent_path.clone()]), rt.call_function('basename', [
					var_child_path.clone()])))
				{
					var_variation_files_parent.array_unset(var_parent_path)
				}
			}
		}
		var_variation_files = rt.call_function('array_merge', [
			var_variation_files.clone(), var_variation_files_parent.clone()])
	}
	rt.call_function('ksort', [var_variation_files.clone()])
	mut iter_6 := var_variation_files.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_file := item_6.val
		mut var_path := item_6.key
		mut var_decoded_file := Class_WP_Theme_JSON_Resolver.read_json_file(var_path.clone())
		if var_decoded_file.clone().is_array()
			&& rt.is_true(Class_WP_Theme_JSON_Resolver.style_variation_has_scope(var_decoded_file.clone(), rt.new_string(scope))) {
			mut var_translated := Class_WP_Theme_JSON_Resolver.translate(var_decoded_file.str(), rt.call_method(rt.call_function('wp_get_theme',
				[]rt.PhpVal{}), 'get', [rt.new_string('TextDomain')]))
			mut var_variation := rt.call_method(create_wp_theme_json(var_translated.clone()),
				'get_raw_data', []rt.PhpVal{})
			if !rt.is_true(var_variation.array_get(rt.new_string('title'))) {
				var_variation.array_set('title', rt.call_function('basename', [
					var_path.clone(),
					rt.new_string('.json'),
				]))
			}
			var_variations.array_push(var_variation.clone())
		}
	}
	return var_variations.clone()
}

fn Class_WP_Theme_JSON_Resolver.get_resolved_theme_uris(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_resolved_theme_uris := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theme_json_mutated,
		'WP_Theme_JSON'))))))
	{
		return var_resolved_theme_uris.clone()
	}
	mut var_theme_json_data := rt.call_method(var_theme_json_mutated, 'get_raw_data', []rt.PhpVal{})
	mut var_placeholder := rt.new_string('file:./')
	mut var_background_image_url := if !(var_theme_json_data.array_get(rt.new_string('styles')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage')).array_get(rt.new_string('url'))).is_null() {
		var_theme_json_data.array_get(rt.new_string('styles')).array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage')).array_get(rt.new_string('url'))
	} else {
		rt.new_null()
	}
	if !var_background_image_url.is_null() && var_background_image_url.clone().is_string()
		&& rt.is_true(rt.call_function('str_starts_with', [var_background_image_url.clone(), var_placeholder.clone()])) {
		mut var_file_type := rt.call_function('wp_check_filetype', [
			var_background_image_url.clone()])
		mut var_src_url := rt.call_function('str_replace', [var_placeholder.clone(),
			rt.new_string(''), var_background_image_url.clone()])
		mut var_resolved_theme_uri := {
			'name':   var_background_image_url
			'href':   rt.call_function('sanitize_url', [
				rt.call_function('get_theme_file_uri', [var_src_url.clone()]),
			])
			'target': rt.new_string('styles.background.backgroundImage.url')
		}
		if var_file_type.array_isset(rt.new_string('type')) {
			var_resolved_theme_uri['type'] = var_file_type.array_get(rt.new_string('type'))
		}
		var_resolved_theme_uris << var_resolved_theme_uri.clone()
	}
	if !(!rt.is_true(var_theme_json_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')))) {
		mut iter_7 :=
			var_theme_json_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_block_styles := item_7.val
			mut var_block_name := item_7.key
			if !(var_block_styles.array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage')).array_isset(rt.new_string('url'))) {
				continue
			}
			var_background_image_url =
				var_block_styles.array_get(rt.new_string('background')).array_get(rt.new_string('backgroundImage')).array_get(rt.new_string('url'))
			if var_background_image_url.clone().is_string()
				&& rt.is_true(rt.call_function('str_starts_with', [var_background_image_url.clone(), var_placeholder.clone()])) {
				var_file_type = rt.call_function('wp_check_filetype', [
					var_background_image_url.clone()])
				var_src_url = rt.call_function('str_replace', [
					var_placeholder.clone(), rt.new_string(''),
					var_background_image_url.clone()])
				var_resolved_theme_uri = {
					'name':   var_background_image_url
					'href':   rt.call_function('sanitize_url', [
						rt.call_function('get_theme_file_uri', [
							var_src_url.clone()]),
					])
					'target': rt.new_string('styles.blocks.${var_block_name.to_string()}.background.backgroundImage.url')
				}
				if var_file_type.array_isset(rt.new_string('type')) {
					var_resolved_theme_uri['type'] = var_file_type.array_get(rt.new_string('type'))
				}
				var_resolved_theme_uris << var_resolved_theme_uri.clone()
			}
		}
	}
	return var_resolved_theme_uris.clone()
}

fn Class_WP_Theme_JSON_Resolver.resolve_theme_file_uris(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	mut var_resolved_urls :=
		Class_WP_Theme_JSON_Resolver.get_resolved_theme_uris(var_theme_json_mutated.clone())
	if !rt.is_true(var_resolved_urls) {
		return var_theme_json_mutated.clone()
	}
	mut var_resolved_theme_json_data := rt.call_method(var_theme_json_mutated, 'get_raw_data',
		[]rt.PhpVal{})
	mut iter_8 := var_resolved_urls.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_resolved_url := item_8.val
		mut var_path := rt.call_function('explode', [rt.new_string('.'),
			var_resolved_url.array_get(rt.new_string('target'))])
		rt.call_function('_wp_array_set', [var_resolved_theme_json_data.clone(),
			var_path.clone(), var_resolved_url.array_get(rt.new_string('href'))])
	}
	return rt.new_object('WP_Theme_JSON', []string{},
		create_wp_theme_json(var_resolved_theme_json_data.clone()))
}

fn Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(var_data rt.PhpVal, var_variations rt.PhpVal) rt.PhpVal {
	mut var_variations_mutated := var_variations
	if !rt.is_true(var_variations_mutated) {
		return var_data.clone()
	}
	mut iter_9 := var_variations_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_variation := item_9.val
		if !rt.is_true(var_variation.array_get(rt.new_string('styles')))
			|| !rt.is_true(var_variation.array_get(rt.new_string('blockTypes'))) {
			continue
		}
		mut var_variation_name := if !(var_variation.array_get(rt.new_string('slug'))).is_null() { var_variation.array_get(rt.new_string('slug')) } else { rt.call_function('_wp_to_kebab_case', [
				var_variation.array_get(rt.new_string('title')),
			]) }
		mut iter_10 := var_variation.array_get(rt.new_string('blockTypes')).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_block_type := item_10.val
			mut var_top_level_data := if !(var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('variations')).array_get(var_variation_name)).is_null() {
				var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('variations')).array_get(var_variation_name)
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_top_level_data)) {
				var_variation.array_set('styles', rt.call_function('array_replace_recursive', [
					var_variation.array_get(rt.new_string('styles')),
					var_top_level_data.clone(),
				]))
			}
			mut var_block_level_data := if !(var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).array_get(var_block_type).array_get(rt.new_string('variations')).array_get(var_variation_name)).is_null() {
				var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).array_get(var_block_type).array_get(rt.new_string('variations')).array_get(var_variation_name)
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_block_level_data)) {
				var_variation.array_set('styles', rt.call_function('array_replace_recursive', [
					var_variation.array_get(rt.new_string('styles')),
					var_block_level_data.clone(),
				]))
			}
			mut var_path := rt.create_array([rt.ArrayItem{ key: none, val: 'styles' },
				rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{
					key: none
					val: var_block_type
				}, rt.ArrayItem{ key: none, val: 'variations' },
				rt.ArrayItem{ key: none, val: var_variation_name }])
			rt.call_function('_wp_array_set', [var_data.clone(),
				var_path.clone(), var_variation.array_get(rt.new_string('styles'))])
		}
	}
	return var_data.clone()
}

fn Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(var_data rt.PhpVal) rt.PhpVal {
	mut iife_temp_3 := Class_WP_Block_Styles_Registry{}
	mut iife_result_3 := iife_temp_3.get_instance()
	mut var_registry := iife_result_3
	mut var_styles := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	mut iter_11 := var_styles.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_variations := item_11.val
		mut var_block_type := item_11.key
		mut iter_12 := var_variations.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_variation := item_12.val
			mut var_variation_name := item_12.key
			if !rt.is_true(var_variation.array_get(rt.new_string('style_data'))) {
				continue
			}
			mut var_top_level_data := if !(var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('variations')).array_get(var_variation_name)).is_null() {
				var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('variations')).array_get(var_variation_name)
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_top_level_data)) {
				var_variation.array_set('style_data', rt.call_function('array_replace_recursive', [
					var_variation.array_get(rt.new_string('style_data')),
					var_top_level_data.clone(),
				]))
			}
			mut var_block_level_data := if !(var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).array_get(var_block_type).array_get(rt.new_string('variations')).array_get(var_variation_name)).is_null() {
				var_data.array_get(rt.new_string('styles')).array_get(rt.new_string('blocks')).array_get(var_block_type).array_get(rt.new_string('variations')).array_get(var_variation_name)
			} else {
				rt.new_array()
			}
			if !(!rt.is_true(var_block_level_data)) {
				var_variation.array_set('style_data', rt.call_function('array_replace_recursive', [
					var_variation.array_get(rt.new_string('style_data')),
					var_block_level_data.clone(),
				]))
			}
			mut var_path := rt.create_array([rt.ArrayItem{ key: none, val: 'styles' },
				rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{
					key: none
					val: var_block_type
				}, rt.ArrayItem{ key: none, val: 'variations' },
				rt.ArrayItem{ key: none, val: var_variation_name }])
			rt.call_function('_wp_array_set', [var_data.clone(),
				var_path.clone(), var_variation.array_get(rt.new_string('style_data'))])
		}
	}
	return var_data.clone()
}

struct Class_WP_Theme_JSON_Data {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_RecursiveIteratorIterator {
	rt.PhpObjectBase
}

struct Class_RecursiveDirectoryIterator {
	rt.PhpObjectBase
}

struct Class_RegexIterator {
	rt.PhpObjectBase
}

struct Class_WP_Block_Styles_Registry {
	rt.PhpObjectBase
}

fn create_wp_theme_json_resolver(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_data(_args ...rt.PhpVal) &Class_WP_Theme_JSON_Data {
	mut obj := &Class_WP_Theme_JSON_Data{
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

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursiveiteratoriterator(_args ...rt.PhpVal) &Class_RecursiveIteratorIterator {
	mut obj := &Class_RecursiveIteratorIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_recursivedirectoryiterator(_args ...rt.PhpVal) &Class_RecursiveDirectoryIterator {
	mut obj := &Class_RecursiveDirectoryIterator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_regexiterator(_args ...rt.PhpVal) &Class_RegexIterator {
	mut obj := &Class_RegexIterator{
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

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'read_json_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.read_json_file(dispatch_arg_0)
		}
		'get_fields_to_translate' {
			return Class_WP_Theme_JSON_Resolver.get_fields_to_translate()
		}
		'translate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON_Resolver.translate(dispatch_arg_0, dispatch_arg_1)
		}
		'get_core_data' {
			return Class_WP_Theme_JSON_Resolver.get_core_data()
		}
		'has_same_registered_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(dispatch_arg_0))
		}
		'get_theme_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.get_theme_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_block_data' {
			return Class_WP_Theme_JSON_Resolver.get_block_data()
		}
		'remove_json_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.remove_json_comments(dispatch_arg_0)
		}
		'get_user_data_from_wp_global_styles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
		}
		'get_user_data' {
			return Class_WP_Theme_JSON_Resolver.get_user_data()
		}
		'get_merged_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON_Resolver.get_merged_data(dispatch_arg_0)
		}
		'get_user_global_styles_post_id' {
			return Class_WP_Theme_JSON_Resolver.get_user_global_styles_post_id()
		}
		'theme_has_support' {
			return Class_WP_Theme_JSON_Resolver.theme_has_support()
		}
		'get_file_path_from_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WP_Theme_JSON_Resolver.get_file_path_from_theme(dispatch_arg_0,
				dispatch_arg_1)
		}
		'clean_cached_data' {
			Class_WP_Theme_JSON_Resolver.clean_cached_data()
			return rt.new_null()
		}
		'recursively_iterate_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.recursively_iterate_json(dispatch_arg_0)
		}
		'style_variation_has_scope' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Theme_JSON_Resolver.style_variation_has_scope(dispatch_arg_0,
				dispatch_arg_1))
		}
		'get_style_variations' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_Theme_JSON_Resolver.get_style_variations(dispatch_arg_0)
		}
		'get_resolved_theme_uris' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.get_resolved_theme_uris(dispatch_arg_0)
		}
		'resolve_theme_file_uris' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.resolve_theme_file_uris(dispatch_arg_0)
		}
		'inject_variations_from_block_style_variation_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(dispatch_arg_0,
				dispatch_arg_1)
		}
		'inject_variations_from_block_styles_registry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Theme_JSON_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveIteratorIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveIteratorIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RecursiveDirectoryIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RecursiveDirectoryIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RecursiveDirectoryIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_RegexIterator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RegexIterator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RegexIterator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
