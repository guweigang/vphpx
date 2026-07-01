import rt

struct Class_WP_Block_Metadata_Registry {
	rt.PhpObjectBase
pub mut:
		collections rt.PhpVal = rt.new_array()
		last_matched_collection rt.PhpVal = rt.new_null()
		default_collection_roots rt.PhpVal = rt.new_null()
}

fn Class_WP_Block_Metadata_Registry.register_collection(var_path rt.PhpVal, var_manifest rt.PhpVal) bool {
	mut var_path_mutated := var_path
	var_path_mutated = rt.new_string(rt.new_string(rt.call_function('wp_normalize_path', [var_path_mutated.dup()]).to_string().trim_right(' \t\n\r')))
	mut var_collection_roots := Class_WP_Block_Metadata_Registry.get_default_collection_roots()
	var_collection_roots = rt.call_function('apply_filters', [rt.new_string('wp_allowed_block_metadata_collection_roots'), var_collection_roots.dup()])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_allowed_root := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('wp_normalize_path', [var_allowed_root.dup()]).to_string().trim_right(' \t\n\r')
	}
	mut var_allowed_root := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('wp_normalize_path', [var_allowed_root.dup()]).to_string().trim_right(' \t\n\r')
	}
	mut var_allowed_root := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('wp_normalize_path', [var_allowed_root.dup()]).to_string().trim_right(' \t\n\r')
	}
	mut var_allowed_root := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('wp_normalize_path', [var_allowed_root.dup()]).to_string().trim_right(' \t\n\r')
	}
	var_collection_roots = rt.call_function('array_unique', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_collection_roots.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WP_Block_Metadata_Registry.is_valid_collection_path(var_path_mutated.dup(), var_collection_roots.dup()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Block metadata collections cannot be registered as one of the following directories or their parent directories: %s')]), rt.call_function('esc_html', [rt.call_function('implode', [rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}), var_collection_roots.dup()])])]), rt.new_string('6.7.2')])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_manifest.dup()]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The specified manifest file does not exist.')]), rt.new_string('6.7.0')])
		return false
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_path_mutated, rt.create_array([rt.ArrayItem{ key: 'manifest', val: var_manifest }, rt.ArrayItem{ key: 'metadata', val: rt.new_null() }]))
	return true
}

fn Class_WP_Block_Metadata_Registry.get_metadata(var_file_or_folder rt.PhpVal) rt.PhpVal {
	mut var_collection := map[string]rt.PhpVal{}
	mut var_file_or_folder_mutated := var_file_or_folder
	var_file_or_folder_mutated = rt.call_function('wp_normalize_path', [var_file_or_folder_mutated.dup()])
	mut var_path := Class_WP_Block_Metadata_Registry.find_collection_path(var_file_or_folder_mutated.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
		return rt.new_null()
	}
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.identical(rt.new_null(), var_collection.array_get('metadata'))) {
		var_collection['metadata'] = rt.include_file((var_collection.array_get('manifest')).to_string(), '3')
	}
	mut var_block_name := Class_WP_Block_Metadata_Registry.default_identifier_callback(var_file_or_folder_mutated.dup())
	return if !(var_collection.array_get('metadata').array_get(var_block_name)).is_null() { var_collection.array_get('metadata').array_get(var_block_name) } else { rt.new_null() }
}

fn Class_WP_Block_Metadata_Registry.get_collection_block_metadata_files(var_path rt.PhpVal) rt.PhpVal {
	mut var_collection := map[string]rt.PhpVal{}
	mut var_path_mutated := var_path
	var_path_mutated = rt.new_string(rt.new_string(rt.call_function('wp_normalize_path', [var_path_mutated.dup()]).to_string().trim_right(' \t\n\r')))
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_path_mutated)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('No registered block metadata collection was found for the provided path.')]), rt.new_string('6.8.0')])
		return rt.new_array()
	}
	// unsupported expression: Expr_AssignRef
	if rt.is_true(rt.identical(rt.new_null(), var_collection.array_get('metadata'))) {
		var_collection['metadata'] = rt.include_file((var_collection.array_get('manifest')).to_string(), '3')
	}
	closure_6_fn := fn [var_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_path] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_block_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("${var_path.to_string()}/${var_block_name.to_string()}/block.json")
	}
	mut var_block_name := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_string("${var_path.to_string()}/${var_block_name.to_string()}/block.json")
	}
	return rt.call_function('array_map', [rt.new_closure(closure_5_fn), rt.func_array_keys(var_collection.array_get('metadata'))])
}

fn Class_WP_Block_Metadata_Registry.find_collection_path(var_file_or_folder rt.PhpVal) rt.PhpVal {
	mut var_file_or_folder_mutated := var_file_or_folder
	if !rt.is_true(var_file_or_folder_mutated) {
		return rt.new_null()
	}
	mut var_path := rt.new_string(rt.new_string(var_file_or_folder_mutated.dup().to_string().trim_right(' \t\n\r')))
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) && rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), // unsupported expression: Expr_StaticPropertyFetch])))) {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_collection_paths := rt.func_array_keys(// unsupported expression: Expr_StaticPropertyFetch)
	{
		mut iter_1 := var_collection_paths.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_collection_path := item_1.val
			if rt.is_true(rt.call_function('str_starts_with', [var_path.dup(), var_collection_path.dup()])) {
				// unsupported assign target: Expr_StaticPropertyFetch
				return var_collection_path.dup()
			}
		}
	}
	return rt.new_null()
}

fn Class_WP_Block_Metadata_Registry.has_metadata(var_file_or_folder rt.PhpVal) rt.PhpVal {
	mut var_file_or_folder_mutated := var_file_or_folder
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn Class_WP_Block_Metadata_Registry.default_identifier_callback(var_path rt.PhpVal) string {
	mut var_path_mutated := var_path
	if !rt.is_true(var_path_mutated) {
		return ''
	}
	if rt.is_true(rt.call_function('str_ends_with', [var_path_mutated.dup(), rt.new_string('block.json')])) {
		return (rt.call_function('basename', [rt.call_function('dirname', [var_path_mutated.dup()])])).str()
	}
	return (rt.call_function('basename', [var_path_mutated.dup()])).str()
}

fn Class_WP_Block_Metadata_Registry.is_valid_collection_path(var_path rt.PhpVal, var_collection_roots rt.PhpVal) bool {
	mut var_path_mutated := var_path
	mut var_collection_roots_mutated := var_collection_roots
	{
		mut iter_1 := var_collection_roots_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_allowed_root := item_1.val
			if rt.is_true(rt.identical(var_allowed_root, var_path_mutated)) {
				return false
			}
			if rt.is_true(rt.call_function('str_starts_with', [var_allowed_root.dup(), var_path_mutated.dup()])) {
				return false
			}
		}
	}
	return true
}

fn Class_WP_Block_Metadata_Registry.get_default_collection_roots() rt.PhpVal {
	if !(// unsupported expression: Expr_StaticPropertyFetch).is_null() {
		return // unsupported expression: Expr_StaticPropertyFetch
	}
	mut var_collection_roots := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_normalize_path', [rt.concat(rt.get_constant('ABSPATH'), rt.get_constant('WPINC'))]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_normalize_path', [rt.get_constant('WP_CONTENT_DIR')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_normalize_path', [rt.get_constant('WPMU_PLUGIN_DIR')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_normalize_path', [rt.get_constant('WP_PLUGIN_DIR')]) }])
	mut var_theme_roots := rt.call_function('get_theme_roots', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_theme_roots.dup().is_array()))))) {
		var_theme_roots = rt.create_array([rt.ArrayItem{ key: none, val: var_theme_roots }])
	}
	{
		mut iter_1 := var_theme_roots.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_theme_root := item_1.val
			var_collection_roots.array_push((rt.call_function('trailingslashit', [rt.call_function('wp_normalize_path', [rt.get_constant('WP_CONTENT_DIR')])])).str() + rt.call_function('wp_normalize_path', [var_theme_root.dup()]).to_string().trim_left(' \t\n\r'))
		}
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn create_wp_block_metadata_registry() &Class_WP_Block_Metadata_Registry {
	mut obj := &Class_WP_Block_Metadata_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		collections: rt.new_array()
		last_matched_collection: rt.new_null()
		default_collection_roots: rt.new_null()
	}
	return obj
}

fn (mut this Class_WP_Block_Metadata_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_collection' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Block_Metadata_Registry.register_collection(dispatch_arg_0, dispatch_arg_1))
		}
		'get_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Block_Metadata_Registry.get_metadata(dispatch_arg_0)
		}
		'get_collection_block_metadata_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Block_Metadata_Registry.get_collection_block_metadata_files(dispatch_arg_0)
		}
		'find_collection_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Block_Metadata_Registry.find_collection_path(dispatch_arg_0)
		}
		'has_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Block_Metadata_Registry.has_metadata(dispatch_arg_0)
		}
		'default_identifier_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Block_Metadata_Registry.default_identifier_callback(dispatch_arg_0))
		}
		'is_valid_collection_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Block_Metadata_Registry.is_valid_collection_path(dispatch_arg_0, dispatch_arg_1))
		}
		'get_default_collection_roots' {
			return Class_WP_Block_Metadata_Registry.get_default_collection_roots()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Metadata_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'collections' { return this.collections }
		'last_matched_collection' { return this.last_matched_collection }
		'default_collection_roots' { return this.default_collection_roots }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Metadata_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'collections' { this.collections = val; return true }
		'last_matched_collection' { this.last_matched_collection = val; return true }
		'default_collection_roots' { this.default_collection_roots = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_block_metadata_registry_php() {
}
