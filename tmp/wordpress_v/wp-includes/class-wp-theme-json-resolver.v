import rt

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
pub mut:
		blocks_cache rt.PhpVal = rt.new_array()
		core rt.PhpVal = rt.new_null()
		blocks rt.PhpVal = rt.new_null()
		theme rt.PhpVal = rt.new_null()
		user rt.PhpVal = rt.new_null()
		user_custom_post_type_id rt.PhpVal = rt.new_null()
		i18n_schema rt.PhpVal = rt.new_null()
		theme_json_file_cache rt.PhpVal = rt.new_array()
}

fn Class_WP_Theme_JSON_Resolver.read_json_file(var_file_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(var_file_path) {
		if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_file_path.dup()))) {
			return // unsupported expression: Expr_StaticPropertyFetch.array_get(var_file_path)
		}
		mut var_decoded_file := rt.call_function('wp_json_file_decode', [var_file_path.dup(), rt.create_array([rt.ArrayItem{ key: 'associative', val: true }])])
		if rt.is_true(rt.new_bool(var_decoded_file.dup().is_array())) {
			// unsupported expression: Expr_StaticPropertyFetch.array_set(var_file_path, var_decoded_file.dup())
			return // unsupported expression: Expr_StaticPropertyFetch.array_get(var_file_path)
		}
	}
	return rt.new_array()
}

fn Class_WP_Theme_JSON_Resolver.get_fields_to_translate() rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.9.0')])
	return rt.new_array()
}

fn Class_WP_Theme_JSON_Resolver.translate(var_theme_json rt.PhpVal, domain string) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		mut var_i18n_schema := rt.call_function('wp_json_file_decode', [@DIR + '/theme-i18n.json'])
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return rt.call_function('translate_settings_using_i18n_schema', [// unsupported expression: Expr_StaticPropertyFetch, var_theme_json_mutated.dup(), rt.new_string(domain)])
}

fn Class_WP_Theme_JSON_Resolver.get_core_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('core'))))) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_config := Class_WP_Theme_JSON_Resolver.read_json_file(rt.new_string(@DIR + '/theme.json'))
	var_config = Class_WP_Theme_JSON_Resolver.translate((var_config).str())
	mut var_theme_json := rt.call_function('apply_filters', [rt.new_string('wp_theme_json_data_default'), create_wp_theme_json_data(var_config.dup(), rt.new_string('default'))])
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else {
		var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(var_origin rt.PhpVal) bool {
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_origin)) {
		return false
	}
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }()
	mut var_blocks := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	mut var_block_diff := rt.call_function('array_diff_key', [var_blocks.dup(), // unsupported expression: Expr_StaticPropertyFetch.array_get(var_origin)])
	if !rt.is_true(var_block_diff) {
		return true
	}
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_type := item_1.val
			mut var_block_name := item_1.key
			// unsupported expression: Expr_StaticPropertyFetch.array_get_mut(var_origin).array_set(var_block_name, true)
		}
	}
	return false
}

fn Class_WP_Theme_JSON_Resolver.get_theme_data(var_deprecated rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	if !(!rt.is_true(var_deprecated)) {
		rt.call_function('_deprecated_argument', [rt.new_string(@METHOD), rt.new_string('5.9.0')])
	}
	var_options_mutated = rt.call_function('wp_parse_args', [var_options_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'with_supports', val: true }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) || rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('theme')))))))) {
		mut var_wp_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
		mut var_theme_json_file := rt.call_method(var_wp_theme, 'get_file_path', [rt.new_string('theme.json')])
		if rt.is_true(rt.call_function('is_readable', [var_theme_json_file.dup()])) {
			mut var_theme_json_data := Class_WP_Theme_JSON_Resolver.read_json_file(var_theme_json_file.dup())
			var_theme_json_data = Class_WP_Theme_JSON_Resolver.translate((var_theme_json_data).str(), rt.call_method(var_wp_theme, 'get', [rt.new_string('TextDomain')]))
		} else {
			var_theme_json_data = rt.create_array([rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() }])
		}
		mut var_variations := Class_WP_Theme_JSON_Resolver.get_style_variations('block')
		rt.call_function('wp_register_block_style_variations_from_theme_json_partials', [var_variations.dup()])
		var_theme_json_data = Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(var_theme_json_data.dup(), var_variations.dup())
		var_theme_json_data = Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(var_theme_json_data.dup())
		mut var_theme_json := rt.call_function('apply_filters', [rt.new_string('wp_theme_json_data_theme'), create_wp_theme_json_data(var_theme_json_data.dup(), rt.new_string('theme'))])
		if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
			// unsupported assign target: Expr_StaticPropertyFetch
		} else {
			mut var_config := rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
			// unsupported assign target: Expr_StaticPropertyFetch
		}
		if rt.is_true(rt.call_method(var_wp_theme, 'parent', []rt.PhpVal{})) {
			mut var_parent_theme_json_file := rt.call_method(rt.call_method(var_wp_theme, 'parent', []rt.PhpVal{}), 'get_file_path', [rt.new_string('theme.json')])
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('is_readable', [var_parent_theme_json_file.dup()])))) {
				mut var_parent_theme_json_data := Class_WP_Theme_JSON_Resolver.read_json_file(var_parent_theme_json_file.dup())
				var_parent_theme_json_data = Class_WP_Theme_JSON_Resolver.translate((var_parent_theme_json_data).str(), rt.call_method(rt.call_method(var_wp_theme, 'parent', []rt.PhpVal{}), 'get', [rt.new_string('TextDomain')]))
				mut var_parent_theme := create_wp_theme_json(var_parent_theme_json_data.dup())
				var_parent_theme.merge(// unsupported expression: Expr_StaticPropertyFetch)
				// unsupported assign target: Expr_StaticPropertyFetch
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get('with_supports'))))) {
		return mut rt.cast_object_ptr[Class_WP_Theme_JSON](// unsupported expression: Expr_StaticPropertyFetch)
	}
	mut var_theme_support_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON{}; return temp.get_from_editor_settings(arg_0) }(rt.call_function('get_classic_theme_supports_block_editor_settings', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{}))))) {
		var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('defaultPalette', !(var_theme_support_data.array_get('settings').array_get('color').array_isset(rt.new_string('palette'))) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-color-palette')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('defaultGradients', !(var_theme_support_data.array_get('settings').array_get('color').array_isset(rt.new_string('gradients'))) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-gradient-presets')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('typography').array_set('defaultFontSizes', !(var_theme_support_data.array_get('settings').array_get('typography').array_isset(rt.new_string('fontSizes'))) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-font-sizes')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('spacing').array_set('defaultSpacingSizes', !(var_theme_support_data.array_get('settings').array_get('spacing').array_isset(rt.new_string('spacingSizes'))) || rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('default-spacing-sizes')])))
		var_theme_support_data.array_get_mut('settings').array_get_mut('shadow').array_set('defaultPresets', false)
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('link-color')])) {
			var_theme_support_data.array_get_mut('settings').array_get_mut('color').array_set('link', true)
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('border')])) {
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('color', true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('radius', true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('style', true)
			var_theme_support_data.array_get_mut('settings').array_get_mut('border').array_set('width', true)
		}
		if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('appearance-tools')])) {
			var_theme_support_data.array_get_mut('settings').array_set('appearanceTools', true)
		}
	}
	mut var_with_theme_supports := create_wp_theme_json(var_theme_support_data.dup())
	var_with_theme_supports.merge(// unsupported expression: Expr_StaticPropertyFetch)
	return mut var_with_theme_supports
}

fn Class_WP_Theme_JSON_Resolver.get_block_data() rt.PhpVal {
	mut var_registry := fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }()
	mut var_blocks := rt.call_method(var_registry, 'get_all_registered', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('blocks'))))) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_config := rt.create_array([rt.ArrayItem{ key: 'version', val: Class_WP_Theme_JSON.latest_schema() }])
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block_type := item_1.val
			mut var_block_name := item_1.key
			if rt.get_property(var_block_type, 'supports').array_isset(rt.new_string('__experimentalStyle')) {
				var_config.array_get_mut('styles').array_get_mut('blocks').array_set(var_block_name, Class_WP_Theme_JSON_Resolver.remove_json_comments(rt.get_property(var_block_type, 'supports').array_get('__experimentalStyle')))
			}
			if rt.get_property(var_block_type, 'supports').array_get('spacing').array_get('blockGap').array_isset(rt.new_string('__experimentalDefault')) && !(var_config.array_get('styles').array_get('blocks').array_get(var_block_name).array_get('spacing').array_isset(rt.new_string('blockGap'))) {
				var_config.array_get_mut('styles').array_get_mut('blocks').array_get_mut(var_block_name).array_get_mut('spacing').array_set('blockGap', rt.new_null())
			}
		}
	}
	mut var_theme_json := rt.call_function('apply_filters', [rt.new_string('wp_theme_json_data_blocks'), create_wp_theme_json_data(var_config.dup(), rt.new_string('blocks'))])
	if rt.is_true(rt.new_bool(rt.instance_of(var_theme_json, 'WP_Theme_JSON_Data'))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else {
		var_config = rt.call_method(var_theme_json, 'get_data', []rt.PhpVal{})
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_WP_Theme_JSON_Resolver.remove_json_comments(var_input_array rt.PhpVal) rt.PhpVal {
	mut var_input_array_mutated := var_input_array
	var_input_array_mutated.array_unset(rt.new_string('//'))
	{
		mut iter_1 := var_input_array_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			mut var_k := item_1.key
			if rt.is_true(rt.new_bool(var_v.dup().is_array())) {
				var_input_array_mutated.array_set(var_k, Class_WP_Theme_JSON_Resolver.remove_json_comments(var_v.dup()))
			}
		}
	}
	return var_input_array_mutated.dup()
}

fn Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles(var_theme rt.PhpVal, create_post bool, var_post_status_filter rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_theme_mutated, 'WP_Theme')))))) {
		var_theme_mutated = rt.call_function('wp_get_theme', []rt.PhpVal{})
	}
	mut var_user_cpt := rt.new_array()
	mut var_post_type_filter := rt.new_string(rt.new_string('wp_global_styles'))
	mut var_stylesheet := rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})
	mut var_args := { 'posts_per_page': rt.new_int(1), 'orderby': rt.new_string('date'), 'order': rt.new_string('desc'), 'post_type': var_post_type_filter, 'post_status': var_post_status_filter, 'ignore_sticky_posts': rt.new_bool(true), 'no_found_rows': rt.new_bool(true), 'update_post_meta_cache': rt.new_bool(false), 'update_post_term_cache': rt.new_bool(false), 'tax_query': map[string]rt.PhpVal{} }
	mut var_global_style_query := create_wp_query()
	mut var_recent_posts := var_global_style_query.query(var_args.dup())
	if rt.is_true(rt.new_bool(var_recent_posts.dup().array_count() == 1 && rt.is_true(rt.new_bool(rt.instance_of(var_recent_posts.array_get(0), 'WP_Post'))))) {
		var_user_cpt = rt.call_function('get_object_vars', [var_recent_posts.array_get(0)])
	} else if var_create_post {
		mut var_cpt_post_id := rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_content', val: '{"version": ' + (Class_WP_Theme_JSON.latest_schema()).str() + ', "isGlobalStylesUserThemeJSON": true }' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_title', val: 'Custom Styles' }, rt.ArrayItem{ key: 'post_type', val: var_post_type_filter }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('sprintf', [rt.new_string('wp-global-styles-%s'), rt.call_function('urlencode', [var_stylesheet.dup()])]) }, rt.ArrayItem{ key: 'tax_input', val: rt.create_array([rt.ArrayItem{ key: 'wp_theme', val: rt.create_array([rt.ArrayItem{ key: none, val: var_stylesheet }]) }]) }]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_cpt_post_id.dup()]))))) {
			mut var_post := rt.call_function('get_post', [var_cpt_post_id.dup()])
			if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
				var_user_cpt = rt.call_function('get_object_vars', [var_post.dup()])
			}
		}
	}
	return var_user_cpt.dup()
}

fn Class_WP_Theme_JSON_Resolver.get_user_data() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(Class_WP_Theme_JSON_Resolver.has_same_registered_blocks(rt.new_string('user'))))) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_config := rt.new_array()
	mut var_user_cpt := Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles((rt.call_function('wp_get_theme', []rt.PhpVal{})).to_bool())
	if rt.is_true(rt.new_bool(var_user_cpt.dup().array_isset(rt.new_string('post_content')))) {
		mut var_decoded_data := rt.call_function('json_decode', [.array_get(), rt.new_bool(true)])
		mut var_json_decoding_error := rt.call_function('json_last_error', []rt.PhpVal{})
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			
		}
		if rt.is_true() {
		}
	}
	mut var_theme_json := 
	if rt.is_true() {
	} else {
	}
	return 
}

fn Class_WP_Theme_JSON_Resolver.get_merged_data(origin string) rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.get_user_global_styles_post_id() rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.theme_has_support() rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.get_file_path_from_theme(var_file_name rt.PhpVal, template bool) rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.clean_cached_data()  {
}

fn Class_WP_Theme_JSON_Resolver.recursively_iterate_json(var_dir rt.PhpVal) rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.style_variation_has_scope(var_variation rt.PhpVal, var_scope rt.PhpVal) bool {
	mut var_variation_mutated := var_variation
}

fn Class_WP_Theme_JSON_Resolver.get_style_variations(scope string) rt.PhpVal {
}

fn Class_WP_Theme_JSON_Resolver.get_resolved_theme_uris(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
}

fn Class_WP_Theme_JSON_Resolver.resolve_theme_file_uris(var_theme_json rt.PhpVal) rt.PhpVal {
	mut var_theme_json_mutated := var_theme_json
}

fn Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(var_data rt.PhpVal, var_variations rt.PhpVal) rt.PhpVal {
	mut var_variations_mutated := var_variations
}

fn Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(var_data rt.PhpVal) rt.PhpVal {
}

struct Class_WP_Theme_JSON_Data {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
		blocks_cache: rt.new_array()
		core: rt.new_null()
		blocks: rt.new_null()
		theme: rt.new_null()
		user: rt.new_null()
		user_custom_post_type_id: rt.new_null()
		i18n_schema: rt.new_null()
		theme_json_file_cache: rt.new_array()
	}
	return obj
}

fn create_wp_theme_json_data() &Class_WP_Theme_JSON_Data {
	mut obj := &Class_WP_Theme_JSON_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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
			return Class_WP_Theme_JSON_Resolver.get_user_data_from_wp_global_styles(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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
			return Class_WP_Theme_JSON_Resolver.get_file_path_from_theme(dispatch_arg_0, dispatch_arg_1)
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
			return rt.new_bool(Class_WP_Theme_JSON_Resolver.style_variation_has_scope(dispatch_arg_0, dispatch_arg_1))
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
			return Class_WP_Theme_JSON_Resolver.inject_variations_from_block_style_variation_files(dispatch_arg_0, dispatch_arg_1)
		}
		'inject_variations_from_block_styles_registry' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Theme_JSON_Resolver.inject_variations_from_block_styles_registry(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'blocks_cache' { return this.blocks_cache }
		'core' { return this.core }
		'blocks' { return this.blocks }
		'theme' { return this.theme }
		'user' { return this.user }
		'user_custom_post_type_id' { return this.user_custom_post_type_id }
		'i18n_schema' { return this.i18n_schema }
		'theme_json_file_cache' { return this.theme_json_file_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'blocks_cache' { this.blocks_cache = val; return true }
		'core' { this.core = val; return true }
		'blocks' { this.blocks = val; return true }
		'theme' { this.theme = val; return true }
		'user' { this.user = val; return true }
		'user_custom_post_type_id' { this.user_custom_post_type_id = val; return true }
		'i18n_schema' { this.i18n_schema = val; return true }
		'theme_json_file_cache' { this.theme_json_file_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_theme_json_resolver_php() {
}
