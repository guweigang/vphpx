import rt

fn wp_register_page_routes(var_page_routes rt.PhpVal, register_function_name string) {
	mut var_build_constants := rt.include_file(@DIR + '/constants.php', '3')
	{
		mut iter_1 := var_page_routes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_route := item_1.val
			mut var_content_handle := rt.new_null()
			mut var_route_handle := rt.new_null()
			if rt.is_true(var_route.array_get('has_content')) {
				mut var_content_asset_path := rt.new_string(@DIR +
					rt.concat(rt.concat(rt.new_string('/routes/'), var_route.array_get('name')), rt.new_string('/content.min.asset.php')))
				if rt.is_true(rt.call_function('file_exists', [
					var_content_asset_path.dup()]))
				{
					mut var_content_asset :=
						rt.include_file(var_content_asset_path.to_string(), '3')
					var_content_handle = rt.new_string('wp/routes/' +
						(var_route.array_get('name')).str() + '/content')
					mut var_extension := if rt.is_true(rt.new_bool(
						rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
						&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))
					{
						'.js'
					} else {
						'.min.js'
					}
					rt.call_function('wp_deregister_script_module', [
						var_content_handle.dup()])
					rt.call_function('wp_register_script_module', [
						var_content_handle.dup(),
						
							(var_build_constants.array_get('build_url')).str() + 'routes/' + (var_route.array_get('name')).str() + '/content' + var_extension,
						if !(var_content_asset.array_get('module_dependencies')).is_null() {
							var_content_asset.array_get('module_dependencies')
						} else {
							rt.new_array()
						}, if !(var_content_asset.array_get('version')).is_null() {
							var_content_asset.array_get('version')
						} else {
							rt.new_bool(false)
						}])
				}
			}
			if rt.is_true(var_route.array_get('has_route')) {
				mut var_route_asset_path := rt.new_string(@DIR +
					rt.concat(rt.concat(rt.new_string('/routes/'), var_route.array_get('name')), rt.new_string('/route.min.asset.php')))
				if rt.is_true(rt.call_function('file_exists', [
					var_route_asset_path.dup()]))
				{
					mut var_route_asset := rt.include_file(var_route_asset_path.to_string(), '3')
					var_route_handle = rt.new_string('wp/routes/' +
						(var_route.array_get('name')).str() + '/route')
					var_extension = if rt.is_true(rt.new_bool(
						rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
						&& rt.is_true(rt.get_constant('SCRIPT_DEBUG'))))
					{
						'.js'
					} else {
						'.min.js'
					}
					rt.call_function('wp_deregister_script_module', [
						var_route_handle.dup()])
					rt.call_function('wp_register_script_module', [
						var_route_handle.dup(),
						
							(var_build_constants.array_get('build_url')).str() + 'routes/' + (var_route.array_get('name')).str() + '/route' + var_extension,
						if !(var_route_asset.array_get('module_dependencies')).is_null() {
							var_route_asset.array_get('module_dependencies')
						} else {
							rt.new_array()
						}, if !(var_route_asset.array_get('version')).is_null() {
							var_route_asset.array_get('version')
						} else {
							rt.new_bool(false)
						}])
				}
			}
			if rt.is_true(rt.call_function('function_exists', [
				rt.new_string(register_function_name),
			]))
			{
				rt.call_function('call_user_func', [
					rt.new_string(register_function_name),
					var_route.array_get('path'),
					var_content_handle.dup(),
					var_route_handle.dup(),
				])
			}
		}
	}
}

fn wp_register_options_connectors_page_routes() {
	mut var_wp_options_connectors_routes_data := rt.new_null()
	// unsupported statement: Stmt_Global
	wp_register_page_routes(var_wp_options_connectors_routes_data.dup(),
		'wp_register_options_connectors_route')
}

fn wp_register_options_connectors_wp_admin_page_routes() {
	mut var_wp_options_connectors_routes_data := rt.new_null()
	// unsupported statement: Stmt_Global
	wp_register_page_routes(var_wp_options_connectors_routes_data.dup(),
		'wp_register_options_connectors_wp_admin_route')
}

fn wp_register_font_library_page_routes() {
	mut var_wp_font_library_routes_data := rt.new_null()
	// unsupported statement: Stmt_Global
	wp_register_page_routes(var_wp_font_library_routes_data.dup(), 'wp_register_font_library_route')
}

fn wp_register_font_library_wp_admin_page_routes() {
	mut var_wp_font_library_routes_data := rt.new_null()
	// unsupported statement: Stmt_Global
	wp_register_page_routes(var_wp_font_library_routes_data.dup(),
		'wp_register_font_library_wp_admin_route')
}

pub fn init_wp_includes_build_routes_php() {
	mut var_GLOBALS := rt.new_null()
	mut var_routes_file := rt.new_string(@DIR + '/routes/registry.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_routes_file.dup()])))))
	{
		return rt.new_null()
	}
	mut var_routes := rt.include_file(var_routes_file.to_string(), '3')
	mut var_routes_by_page := rt.new_array()
	{
		mut iter_1 := var_routes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_route := item_1.val
			mut var_page_slug := var_route.array_get('page')
			if !(var_routes_by_page.array_isset(var_page_slug)) {
				var_routes_by_page.array_set(var_page_slug, rt.new_array())
			}
			var_routes_by_page.array_get_mut(var_page_slug).array_push(var_route.dup())
		}
	}
	{
		mut iter_1 := var_routes_by_page.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_page_routes := item_1.val
			mut var_page_slug := item_1.key
			mut var_page_slug_underscore := rt.call_function('str_replace', [
				rt.new_string('-'),
				rt.new_string('_'),
				var_page_slug.dup(),
			])
			mut var_global_name := rt.new_string('wp_' + var_page_slug_underscore.str() +
				'_routes_data')
			var_GLOBALS.array_set(var_global_name, var_page_routes.dup())
		}
	}
	rt.call_function('add_action', [rt.new_string('options-connectors_init'),
		rt.new_string('wp_register_options_connectors_page_routes')])
	rt.call_function('add_action', [rt.new_string('options-connectors-wp-admin_init'),
		rt.new_string('wp_register_options_connectors_wp_admin_page_routes')])
	rt.call_function('add_action', [rt.new_string('font-library_init'),
		rt.new_string('wp_register_font_library_page_routes')])
	rt.call_function('add_action', [rt.new_string('font-library-wp-admin_init'),
		rt.new_string('wp_register_font_library_wp_admin_page_routes')])
}
