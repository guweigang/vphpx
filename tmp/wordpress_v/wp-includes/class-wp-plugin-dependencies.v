import rt

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
pub mut:
		plugins rt.PhpVal = rt.new_null()
		plugin_dirnames rt.PhpVal = rt.new_null()
		dependencies rt.PhpVal = rt.new_null()
		dependency_slugs rt.PhpVal = rt.new_null()
		dependent_slugs rt.PhpVal = rt.new_null()
		dependency_api_data rt.PhpVal = rt.new_null()
		dependency_filepaths rt.PhpVal = rt.new_null()
		circular_dependencies_pairs rt.PhpVal = rt.new_null()
		circular_dependencies_slugs rt.PhpVal = rt.new_null()
		initialized rt.PhpVal = rt.new_bool(false)
}

fn Class_WP_Plugin_Dependencies.initialize()  {
	if rt.is_true(rt.identical(rt.new_bool(false), // unsupported expression: Expr_StaticPropertyFetch)) {
		Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers()
		Class_WP_Plugin_Dependencies.get_dependency_api_data()
		// unsupported assign target: Expr_StaticPropertyFetch
	}
}

fn Class_WP_Plugin_Dependencies.has_dependents(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return rt.call_function('in_array', [Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.dup()), rt.cast_array(// unsupported expression: Expr_StaticPropertyFetch), rt.new_bool(true)])
}

fn Class_WP_Plugin_Dependencies.has_dependencies(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_plugin_file_mutated))
}

fn Class_WP_Plugin_Dependencies.has_active_dependents(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_dependents := Class_WP_Plugin_Dependencies.get_dependents(Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.dup()))
	{
		mut iter_1 := var_dependents.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependent := item_1.val
			if rt.is_true(rt.call_function('is_plugin_active', [var_dependent.dup()])) {
				return true
			}
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.get_dependents(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_dependents := rt.new_array()
	{
		mut iter_1 := rt.cast_array(// unsupported expression: Expr_StaticPropertyFetch).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependencies := item_1.val
			mut var_dependent := item_1.key
			if rt.is_true(rt.call_function('in_array', [var_slug_mutated.dup(), var_dependencies.dup(), rt.new_bool(true)])) {
				var_dependents.array_push(var_dependent.dup())
			}
		}
	}
	return var_dependents.dup()
}

fn Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	return if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_plugin_file_mutated)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_plugin_file_mutated) } else { rt.new_array() }
}

fn Class_WP_Plugin_Dependencies.get_dependent_filepath(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_filepath := rt.call_function('array_search', [var_slug_mutated.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])
	return if rt.is_true(var_filepath) { var_filepath } else { rt.new_bool(false) }
}

fn Class_WP_Plugin_Dependencies.has_unmet_dependencies(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_plugin_file_mutated)) {
		return false
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	{
		mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_plugin_file_mutated).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependency := item_1.val
			mut var_dependency_filepath := Class_WP_Plugin_Dependencies.get_dependency_filepath(var_dependency.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_dependency_filepath)) || rt.is_true(rt.call_function('is_plugin_inactive', [var_dependency_filepath.dup()])))) {
				return true
			}
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.has_circular_dependency(var_plugin_file rt.PhpVal) bool {
	mut var_plugin_file_mutated := var_plugin_file
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.is_array()))))) {
		Class_WP_Plugin_Dependencies.get_circular_dependencies()
	}
	if !(!rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)) {
		mut var_slug := Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.dup())
		if rt.is_true(rt.call_function('in_array', [var_slug.dup(), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])) {
			return true
		}
	}
	return false
}

fn Class_WP_Plugin_Dependencies.get_dependent_names(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	mut var_dependent_names := rt.new_array()
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	mut var_slug := Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file_mutated.dup())
	{
		mut iter_1 := Class_WP_Plugin_Dependencies.get_dependents(var_slug.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependent := item_1.val
			var_dependent_names.array_set(var_dependent, var_plugins.array_get(var_dependent).array_get('Name'))
		}
	}
	rt.call_function('sort', [var_dependent_names.dup()])
	return var_dependent_names.dup()
}

fn Class_WP_Plugin_Dependencies.get_dependency_names(var_plugin_file rt.PhpVal) rt.PhpVal {
	mut var_plugin_file_mutated := var_plugin_file
	mut var_dependency_api_data := Class_WP_Plugin_Dependencies.get_dependency_api_data()
	mut var_dependencies := Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file_mutated.dup())
	mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
	mut var_dependency_names := rt.new_array()
	{
		mut iter_1 := var_dependencies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependency := item_1.val
			if var_dependency_api_data.array_get(var_dependency).array_isset(rt.new_string('name')) {
				mut var_name := var_dependency_api_data.array_get(var_dependency).array_get('name')
			} else {
				mut var_dependency_filepath := Class_WP_Plugin_Dependencies.get_dependency_filepath(var_dependency.dup())
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_name = var_plugins.array_get(var_dependency_filepath).array_get('Name')
				} else {
					var_name = var_dependency
				}
			}
			var_dependency_names.array_set(var_dependency, var_name.dup())
		}
	}
	return var_dependency_names.dup()
}

fn Class_WP_Plugin_Dependencies.get_dependency_filepath(var_slug rt.PhpVal) bool {
	mut var_slug_mutated := var_slug
	mut var_dependency_filepaths := Class_WP_Plugin_Dependencies.get_dependency_filepaths()
	if !(var_dependency_filepaths.array_isset(var_slug_mutated)) {
		return false
	}
	return (var_dependency_filepaths.array_get(var_slug_mutated)).to_bool()
}

fn Class_WP_Plugin_Dependencies.get_dependency_data(var_slug rt.PhpVal) rt.PhpVal {
	mut var_slug_mutated := var_slug
	mut var_dependency_api_data := Class_WP_Plugin_Dependencies.get_dependency_api_data()
	return if !(var_dependency_api_data.array_get(var_slug_mutated)).is_null() { var_dependency_api_data.array_get(var_slug_mutated) } else { rt.new_bool(false) }
}

fn Class_WP_Plugin_Dependencies.display_admin_notice_for_unmet_dependencies()  {
	if rt.is_true(rt.call_function('in_array', [rt.new_bool(false), Class_WP_Plugin_Dependencies.get_dependency_filepaths(), rt.new_bool(true)])) {
		mut var_error_message := rt.call_function('__', [rt.new_string('Some required plugins are missing or inactive.')])
		if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				// unsupported expression: Expr_AssignOp_Concat
			}
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		rt.call_function('wp_admin_notice', [var_error_message.dup(), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }])])
	}
}

fn Class_WP_Plugin_Dependencies.display_admin_notice_for_circular_dependencies()  {
	mut var_circular_dependencies := Class_WP_Plugin_Dependencies.get_circular_dependencies()
	if !(!rt.is_true(var_circular_dependencies)) && var_circular_dependencies.dup().array_count() > 1 {
		var_circular_dependencies = rt.call_function('array_unique', [var_circular_dependencies.dup(), rt.get_constant('SORT_REGULAR')])
		mut var_plugins := Class_WP_Plugin_Dependencies.get_plugins()
		mut var_plugin_dirnames := Class_WP_Plugin_Dependencies.get_plugin_dirnames()
		mut var_circular_dependency_lines := rt.new_string(rt.new_string(''))
		{
			mut iter_1 := var_circular_dependencies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_circular_dependency := item_1.val
				mut var_first_filepath := var_plugin_dirnames.array_get(var_circular_dependency.array_get(0))
				mut var_second_filepath := var_plugin_dirnames.array_get(var_circular_dependency.array_get(1))
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		rt.call_function('wp_admin_notice', [rt.call_function('sprintf', [rt.new_string('<p>%1$s</p><ul>%2$s</ul><p>%3$s</p>'), rt.call_function('__', [rt.new_string('These plugins cannot be activated because their requirements are invalid.')]), var_circular_dependency_lines.dup(), rt.call_function('__', [rt.new_string('Please contact the plugin authors for more information.')])]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'warning' }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	}
}

fn Class_WP_Plugin_Dependencies.check_plugin_dependencies_during_ajax()  {
	rt.call_function('check_ajax_referer', [rt.new_string('updates')])
	if !rt.is_true(rt.get_superglobal('_POST').array_get('slug')) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'slug', val: '' }, rt.ArrayItem{ key: 'pluginName', val: '' }, rt.ArrayItem{ key: 'errorCode', val: 'no_plugin_specified' }, rt.ArrayItem{ key: 'errorMessage', val: rt.call_function('__', [rt.new_string('No plugin specified.')]) }])])
	}
	mut var_slug := rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('slug')])])
	mut var_status := { 'slug': var_slug }
	Class_WP_Plugin_Dependencies.get_plugins()
	Class_WP_Plugin_Dependencies.get_plugin_dirnames()
	if !(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_slug)) {
		var_status['errorCode'] = rt.new_string('plugin_not_installed')
		var_status['errorMessage'] = rt.call_function('__', [rt.new_string('The plugin is not installed.')])
		rt.call_function('wp_send_json_error', [var_status.dup()])
	}
	mut var_plugin_file := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_slug)
	var_status['pluginName'] = // unsupported expression: Expr_StaticPropertyFetch.array_get(var_plugin_file).array_get('Name')
	var_status['plugin'] = var_plugin_file.dup()
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugin'), var_plugin_file.dup()])) && rt.is_true(rt.call_function('is_plugin_inactive', [var_plugin_file.dup()])))) {
		var_status['activateUrl'] = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', ['activate-plugin_' + (var_plugin_file).str()]) }, rt.ArrayItem{ key: 'action', val: 'activate' }, rt.ArrayItem{ key: 'plugin', val: var_plugin_file }]), if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.call_function('network_admin_url', [rt.new_string('plugins.php')]) } else { rt.call_function('admin_url', [rt.new_string('plugins.php')]) }])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])))) {
		var_status['activateUrl'] = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'networkwide', val: 1 }]), var_status.array_get('activateUrl')])
	}
	Class_WP_Plugin_Dependencies.initialize()
	mut var_dependencies := Class_WP_Plugin_Dependencies.get_dependencies(var_plugin_file.dup())
	if !rt.is_true(var_dependencies) {
		var_status['message'] = rt.call_function('__', [rt.new_string('The plugin has no required plugins.')])
		rt.call_function('wp_send_json_success', [var_status.dup()])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_inactive_dependencies := rt.new_array()
	{
		mut iter_1 := var_dependencies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dependency := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), // unsupported expression: Expr_StaticPropertyFetch.array_get(var_dependency))) || rt.is_true(rt.call_function('is_plugin_inactive', [// unsupported expression: Expr_StaticPropertyFetch.array_get(var_dependency)])))) {
				var_inactive_dependencies << var_dependency.dup()
			}
		}
	}
	if !(!rt.is_true(var_inactive_dependencies)) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_dependency := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if // unsupported expression: Expr_StaticPropertyFetch.array_get(var_dependency).array_isset(rt.new_string('Name')) {
		mut var_inactive_dependency_name := // unsupported expression: Expr_StaticPropertyFetch.array_get(var_dependency).array_get('Name')
	} else {
		var_inactive_dependency_name = var_dependency
	}
	return var_inactive_dependency_name.dup()
	}
	mut var_dependency := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if // unsupported expression: Expr_StaticPropertyFetch.array_get(var_dependency).array_isset(rt.new_string('Name')) {
		mut var_inactive_dependency_name := .array_get()
	} else {
		var_inactive_dependency_name = 
	}
	return var_inactive_dependency_name.dup()
	}
		mut var_inactive_dependency_names := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_inactive_dependencies.dup()])
		var_status['errorCode'] = rt.new_string('inactive_dependencies')
		var_status['errorMessage'] = rt.call_function('sprintf', [, ])
		[] = 
		
	}
	
}

fn Class_WP_Plugin_Dependencies.get_plugins() rt.PhpVal {
}

fn Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers()  {
}

fn Class_WP_Plugin_Dependencies.sanitize_dependency_slugs(var_slugs rt.PhpVal) rt.PhpVal {
	mut var_slugs_mutated := var_slugs
}

fn Class_WP_Plugin_Dependencies.get_dependency_filepaths() rt.PhpVal {
}

fn Class_WP_Plugin_Dependencies.get_dependency_api_data() rt.PhpVal {
	mut var_pagenow := rt.new_null()
}

fn Class_WP_Plugin_Dependencies.get_plugin_dirnames() rt.PhpVal {
}

fn Class_WP_Plugin_Dependencies.get_circular_dependencies() rt.PhpVal {
}

fn Class_WP_Plugin_Dependencies.check_for_circular_dependencies(var_dependents rt.PhpVal, var_dependencies rt.PhpVal) rt.PhpVal {
	mut var_dependents_mutated := var_dependents
	mut var_dependencies_mutated := var_dependencies
}

fn Class_WP_Plugin_Dependencies.convert_to_slug(var_plugin_file rt.PhpVal) string {
	mut var_plugin_file_mutated := var_plugin_file
}

fn create_wp_plugin_dependencies() &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
		plugins: rt.new_null()
		plugin_dirnames: rt.new_null()
		dependencies: rt.new_null()
		dependency_slugs: rt.new_null()
		dependent_slugs: rt.new_null()
		dependency_api_data: rt.new_null()
		dependency_filepaths: rt.new_null()
		circular_dependencies_pairs: rt.new_null()
		circular_dependencies_slugs: rt.new_null()
		initialized: rt.new_bool(false)
	}
	return obj
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			Class_WP_Plugin_Dependencies.initialize()
			return rt.new_null()
		}
		'has_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.has_dependents(dispatch_arg_0)
		}
		'has_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.has_dependencies(dispatch_arg_0)
		}
		'has_active_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_active_dependents(dispatch_arg_0))
		}
		'get_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependents(dispatch_arg_0)
		}
		'get_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependencies(dispatch_arg_0)
		}
		'get_dependent_filepath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependent_filepath(dispatch_arg_0)
		}
		'has_unmet_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_unmet_dependencies(dispatch_arg_0))
		}
		'has_circular_dependency' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.has_circular_dependency(dispatch_arg_0))
		}
		'get_dependent_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependent_names(dispatch_arg_0)
		}
		'get_dependency_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependency_names(dispatch_arg_0)
		}
		'get_dependency_filepath' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Plugin_Dependencies.get_dependency_filepath(dispatch_arg_0))
		}
		'get_dependency_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.get_dependency_data(dispatch_arg_0)
		}
		'display_admin_notice_for_unmet_dependencies' {
			Class_WP_Plugin_Dependencies.display_admin_notice_for_unmet_dependencies()
			return rt.new_null()
		}
		'display_admin_notice_for_circular_dependencies' {
			Class_WP_Plugin_Dependencies.display_admin_notice_for_circular_dependencies()
			return rt.new_null()
		}
		'check_plugin_dependencies_during_ajax' {
			Class_WP_Plugin_Dependencies.check_plugin_dependencies_during_ajax()
			return rt.new_null()
		}
		'get_plugins' {
			return Class_WP_Plugin_Dependencies.get_plugins()
		}
		'read_dependencies_from_plugin_headers' {
			Class_WP_Plugin_Dependencies.read_dependencies_from_plugin_headers()
			return rt.new_null()
		}
		'sanitize_dependency_slugs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.sanitize_dependency_slugs(dispatch_arg_0)
		}
		'get_dependency_filepaths' {
			return Class_WP_Plugin_Dependencies.get_dependency_filepaths()
		}
		'get_dependency_api_data' {
			return Class_WP_Plugin_Dependencies.get_dependency_api_data()
		}
		'get_plugin_dirnames' {
			return Class_WP_Plugin_Dependencies.get_plugin_dirnames()
		}
		'get_circular_dependencies' {
			return Class_WP_Plugin_Dependencies.get_circular_dependencies()
		}
		'check_for_circular_dependencies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Plugin_Dependencies.check_for_circular_dependencies(dispatch_arg_0, dispatch_arg_1)
		}
		'convert_to_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Plugin_Dependencies.convert_to_slug(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugins' { return this.plugins }
		'plugin_dirnames' { return this.plugin_dirnames }
		'dependencies' { return this.dependencies }
		'dependency_slugs' { return this.dependency_slugs }
		'dependent_slugs' { return this.dependent_slugs }
		'dependency_api_data' { return this.dependency_api_data }
		'dependency_filepaths' { return this.dependency_filepaths }
		'circular_dependencies_pairs' { return this.circular_dependencies_pairs }
		'circular_dependencies_slugs' { return this.circular_dependencies_slugs }
		'initialized' { return this.initialized }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugins' { this.plugins = val; return true }
		'plugin_dirnames' { this.plugin_dirnames = val; return true }
		'dependencies' { this.dependencies = val; return true }
		'dependency_slugs' { this.dependency_slugs = val; return true }
		'dependent_slugs' { this.dependent_slugs = val; return true }
		'dependency_api_data' { this.dependency_api_data = val; return true }
		'dependency_filepaths' { this.dependency_filepaths = val; return true }
		'circular_dependencies_pairs' { this.circular_dependencies_pairs = val; return true }
		'circular_dependencies_slugs' { this.circular_dependencies_slugs = val; return true }
		'initialized' { this.initialized = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_wp_plugin_dependencies_php() {
}
