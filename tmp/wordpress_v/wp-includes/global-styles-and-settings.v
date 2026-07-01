import rt
import crypto.md5

fn wp_get_global_settings(var_path rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_context.array_get('block_name'))) {
		mut var_new_path := [rt.new_string('blocks'), var_context.array_get('block_name')]
		{
			mut iter_1 := var_path.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_subpath := item_1.val
				var_new_path << var_subpath.dup()
			}
		}
		var_path = var_new_path.dup()
	}
	mut var_origin := 'custom'
	if rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('origin')) && rt.is_true(rt.identical(rt.new_string('base'), var_context.array_get('origin'))))) {
		var_origin = 'theme'
	}
	mut var_cache_group := 'theme_json'
	mut var_cache_key := rt.new_string('wp_get_global_settings_' + var_origin)
	mut var_can_use_cached := !(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')])))
	mut var_settings := rt.new_bool(rt.new_bool(false))
	if var_can_use_cached {
		var_settings = rt.call_function('wp_cache_get', [var_cache_key.dup(), rt.new_string(var_cache_group).dup()])
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_settings)) {
		var_settings = rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_merged_data(arg_0) }(rt.new_string(var_origin)), 'get_settings', []rt.PhpVal{})
		if var_can_use_cached {
			rt.call_function('wp_cache_set', [var_cache_key.dup(), var_settings.dup(), rt.new_string(var_cache_group).dup()])
		}
	}
	return rt.call_function('_wp_array_get', [var_settings.dup(), var_path.dup(), var_settings.dup()])
}

fn wp_get_global_styles(var_path rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_context.array_get('block_name'))) {
		var_path = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' }, rt.ArrayItem{ key: none, val: var_context.array_get('block_name') }]), var_path.dup()])
	}
	mut var_origin := 'custom'
	if rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('origin')) && rt.is_true(rt.identical(rt.new_string('base'), var_context.array_get('origin'))))) {
		var_origin = 'theme'
	}
	mut var_resolve_variables := rt.is_true(rt.new_bool(var_context.array_isset(rt.new_string('transforms')) && rt.is_true(rt.new_bool(var_context.array_get('transforms').is_array())))) && rt.is_true(rt.call_function('in_array', [rt.new_string('resolve-variables'), var_context.array_get('transforms'), rt.new_bool(true)]))
	mut var_merged_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_merged_data(arg_0) }(rt.new_string(var_origin))
	if var_resolve_variables {
		var_merged_data = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON{}; return temp.resolve_variables(arg_0) }(var_merged_data.dup())
	}
	mut var_styles := rt.call_method(var_merged_data, 'get_raw_data', []rt.PhpVal{}).array_get('styles')
	return rt.call_function('_wp_array_get', [var_styles.dup(), var_path.dup(), var_styles.dup()])
}

fn wp_get_global_stylesheet(var_types rt.PhpVal) rt.PhpVal {
	mut var_can_use_cached := !rt.is_true(var_types) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')])))))
	mut var_cache_group := 'theme_json'
	mut var_cache_key := 'wp_get_global_stylesheet'
	if var_can_use_cached {
		mut var_cached := rt.call_function('wp_cache_get', [rt.new_string(var_cache_key).dup(), rt.new_string(var_cache_group).dup()])
		if rt.is_true(var_cached) {
			return var_cached.dup()
		}
	}
	mut var_tree := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.resolve_theme_file_uris(arg_0) }(fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_merged_data() }())
	if !rt.is_true(var_types) {
		var_types = rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }, rt.ArrayItem{ key: none, val: 'styles' }, rt.ArrayItem{ key: none, val: 'presets' }])
	}
	mut var_options := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(wp_theme_has_theme_json())))))) {
		var_options['base_layout_styles'] = true
	}
	mut var_styles_variables := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('in_array', [rt.new_string('variables'), var_types.dup(), rt.new_bool(true)])) {
		mut var_origins := ['default', 'theme', 'custom']
		var_styles_variables = rt.call_method(var_tree, 'get_stylesheet', [rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }]), var_origins.dup(), var_options.dup()])
		var_types = rt.call_function('array_diff', [var_types.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'variables' }])])
	}
	mut var_styles_rest := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(var_types)) {
		var_origins = ['default', 'theme', 'custom']
		var_styles_rest = rt.call_method(var_tree, 'get_stylesheet', [var_types.dup(), var_origins.dup(), var_options.dup()])
	}
	mut var_stylesheet := rt.new_string(rt.concat(var_styles_variables, var_styles_rest))
	if var_can_use_cached {
		rt.call_function('wp_cache_set', [rt.new_string(var_cache_key).dup(), var_stylesheet.dup(), rt.new_string(var_cache_group).dup()])
	}
	return var_stylesheet.dup()
}

fn wp_add_global_styles_for_blocks() {
	mut var_wp_styles := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_tree := fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_merged_data() }()
	var_tree = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.resolve_theme_file_uris(arg_0) }(var_tree.dup())
	mut var_block_nodes := rt.call_method(var_tree, 'get_styles_block_nodes', []rt.PhpVal{})
	mut var_can_use_cached := !(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')])))
	mut var_update_cache := false
	if var_can_use_cached {
		mut var_cache_hash := md5.hexhash(rt.call_function('wp_json_encode', [rt.call_method(var_tree, 'get_raw_data', []rt.PhpVal{})]).to_string())
		mut var_cache_key := 'wp_styles_for_blocks'
		mut var_cached := rt.call_function('get_transient', [rt.new_string(var_cache_key).dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cached.dup().is_array()))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_cached = rt.create_array([rt.ArrayItem{ key: 'hash', val: var_cache_hash }, rt.ArrayItem{ key: 'blocks', val: map[string]rt.PhpVal{} }])
			var_update_cache = true
		}
	}
	{
		mut iter_1 := var_block_nodes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_metadata := item_1.val
			if var_can_use_cached {
				mut var_cache_node_key := md5.hexhash(rt.call_function('wp_json_encode', [var_metadata.dup()]).to_string())
				if var_cached.array_get('blocks').array_isset(rt.new_string(var_cache_node_key)) {
					mut var_block_css := var_cached.array_get('blocks').array_get(var_cache_node_key)
				} else {
					var_block_css = rt.call_method(var_tree, 'get_styles_for_block', [var_metadata.dup()])
					var_cached.array_get_mut('blocks').array_set(var_cache_node_key, var_block_css.dup())
					var_update_cache = true
				}
			} else {
				var_block_css = rt.call_method(var_tree, 'get_styles_for_block', [var_metadata.dup()])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_should_load_block_assets_on_demand', []rt.PhpVal{}))))) {
				rt.call_function('wp_add_inline_style', [rt.new_string('global-styles'), var_block_css.dup()])
				continue
			}
			mut var_stylesheet_handle := 'global-styles'
			if var_metadata.array_isset(rt.new_string('name')) {
				if rt.is_true(rt.call_function('str_starts_with', [var_metadata.array_get('name'), rt.new_string('core/')])) {
					mut var_block_name := rt.call_function('str_replace', [rt.new_string('core/'), rt.new_string(''), var_metadata.array_get('name')])
					mut var_block_handle := rt.new_string('wp-block-' + (var_block_name).str())
					if rt.is_true(rt.call_function('in_array', [var_block_handle.dup(), rt.get_property(var_wp_styles, 'queue'), rt.new_bool(true)])) {
						rt.call_function('wp_add_inline_style', [rt.new_string(var_stylesheet_handle).dup(), var_block_css.dup()])
					}
				} else {
					rt.call_function('wp_add_inline_style', [rt.new_string(var_stylesheet_handle).dup(), var_block_css.dup()])
				}
			}
			if !(var_metadata.array_isset(rt.new_string('name'))) && !(!rt.is_true(var_metadata.array_get('path'))) {
				var_block_name = wp_get_block_name_from_theme_json_path(var_metadata.array_get('path'))
				if rt.is_true(var_block_name) {
					if rt.is_true(rt.call_function('str_starts_with', [var_block_name.dup(), rt.new_string('core/')])) {
						var_block_name = rt.call_function('str_replace', [rt.new_string('core/'), rt.new_string(''), var_block_name.dup()])
						var_block_handle = rt.new_string('wp-block-' + (var_block_name).str())
						if rt.is_true(rt.call_function('in_array', [var_block_handle.dup(), rt.get_property(var_wp_styles, 'queue'), rt.new_bool(true)])) {
							rt.call_function('wp_add_inline_style', [rt.new_string(var_stylesheet_handle).dup(), var_block_css.dup()])
						}
					} else {
						rt.call_function('wp_add_inline_style', [rt.new_string(var_stylesheet_handle).dup(), var_block_css.dup()])
					}
				}
			}
		}
	}
	if var_update_cache {
		rt.call_function('set_transient', [rt.new_string(var_cache_key).dup(), var_cached.dup()])
	}
}

fn wp_get_block_name_from_theme_json_path(var_path rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_path.dup().array_count() >= 3 && rt.is_true(rt.identical(rt.new_string('styles'), var_path.array_get(0))))) && rt.is_true(rt.identical(rt.new_string('blocks'), var_path.array_get(1))))) && rt.is_true(rt.call_function('str_contains', [var_path.array_get(2), rt.new_string('/')])))) {
		return var_path.array_get(2)
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.call_function('str_contains', [var_item.dup(), rt.new_string('core/')])) {
		return rt.new_bool(true)
	}
	return rt.new_bool(false)
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.call_function('str_contains', [var_item.dup(), rt.new_string('core/')])) {
		return rt.new_bool(true)
	}
	return rt.new_bool(false)
	}
	mut var_result := rt.call_function('array_values', [rt.call_function('array_filter', [var_path.dup(), rt.new_closure(closure_1_fn)])])
	return if !(var_result.array_get(0)).is_null() { var_result.array_get(0) } else { rt.new_string('') }
}

fn wp_theme_has_theme_json() rt.PhpVal {
	mut var_theme_has_support := rt.new_null()
	// unsupported statement: Stmt_Static
	mut var_stylesheet := rt.call_function('get_stylesheet', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_theme_has_support.array_isset(var_stylesheet) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_development_mode', [rt.new_string('theme')]))))))) {
		return var_theme_has_support.array_get(var_stylesheet)
	}
	mut var_stylesheet_directory := rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
	mut var_template_directory := rt.call_function('get_template_directory', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('file_exists', [(var_stylesheet_directory).str() + '/theme.json'])))) {
		mut var_path := rt.new_string((var_stylesheet_directory).str() + '/theme.json')
	} else {
		var_path = rt.new_string((var_template_directory).str() + '/theme.json')
	}
	var_path = rt.call_function('apply_filters', [rt.new_string('theme_file_path'), var_path.dup(), rt.new_string('theme.json')])
	var_theme_has_support.array_set(var_stylesheet, rt.call_function('file_exists', [var_path.dup()]))
	return var_theme_has_support.array_get(var_stylesheet)
}

fn wp_clean_theme_json_cache() {
	rt.call_function('wp_cache_delete', [rt.new_string('wp_get_global_stylesheet'), rt.new_string('theme_json')])
	rt.call_function('wp_cache_delete', [rt.new_string('wp_get_global_styles_svg_filters'), rt.new_string('theme_json')])
	rt.call_function('wp_cache_delete', [, ])
	
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
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




pub fn init_wp_includes_global_styles_and_settings_php() {
}
