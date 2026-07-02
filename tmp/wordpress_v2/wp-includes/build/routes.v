import rt

fn wp_register_page_routes(var_page_routes rt.PhpVal, register_function_name string) {
	mut var_register_function_name := register_function_name
	mut var_build_constants := rt.new_null()
	mut var_route := map[string]rt.PhpVal{}
	mut var_content_handle := rt.new_null()
	mut var_route_handle := rt.new_null()
	mut var_content_asset_path := rt.new_null()
	mut var_content_asset := rt.new_null()
	mut var_extension := ''
	mut var_route_asset_path := rt.new_null()
	mut var_route_asset := rt.new_null()
	var_build_constants = rt.include_file(@DIR + '/constants.php', '3')
	mut iter_3 := var_page_routes.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_route_shadow := item_3.val
		var_content_handle = rt.new_null()
		var_route_handle = rt.new_null()
		if rt.is_true(var_route_shadow['has_content']) {
			var_content_asset_path = rt.new_string(@DIR +
				rt.concat(rt.concat(rt.new_string('/routes/'), var_route_shadow['name']), rt.new_string('/content.min.asset.php')))
			if rt.is_true(rt.call_function('file_exists', [var_content_asset_path.clone()])) {
				var_content_asset = rt.include_file(var_content_asset_path.to_string(), '3')
				var_content_handle = rt.new_string('wp/routes/' +
					(var_route_shadow['name']).str() + '/content')
				var_extension = if
					rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
					&& rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
					'.js'
				} else {
					'.min.js'
				}
				rt.call_function('wp_deregister_script_module', [
					var_content_handle.clone()])
				rt.call_function('wp_register_script_module', [
					var_content_handle.clone(),
					rt.new_string(
						(var_build_constants.array_get(rt.new_string('build_url'))).str() + 'routes/' + (var_route_shadow['name']).str() + '/content' + var_extension),
					if !(var_content_asset.array_get(rt.new_string('module_dependencies'))).is_null() {
						var_content_asset.array_get(rt.new_string('module_dependencies'))
					} else {
						rt.new_array()
					}, if !(var_content_asset.array_get(rt.new_string('version'))).is_null() {
						var_content_asset.array_get(rt.new_string('version'))
					} else {
						rt.new_bool(false)
					}])
			}
		}
		if rt.is_true(var_route_shadow['has_route']) {
			var_route_asset_path = rt.new_string(@DIR +
				rt.concat(rt.concat(rt.new_string('/routes/'), var_route_shadow['name']), rt.new_string('/route.min.asset.php')))
			if rt.is_true(rt.call_function('file_exists', [var_route_asset_path.clone()])) {
				var_route_asset = rt.include_file(var_route_asset_path.to_string(), '3')
				var_route_handle = rt.new_string('wp/routes/' +
					(var_route_shadow['name']).str() + '/route')
				var_extension = if
					rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
					&& rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
					'.js'
				} else {
					'.min.js'
				}
				rt.call_function('wp_deregister_script_module', [
					var_route_handle.clone()])
				rt.call_function('wp_register_script_module', [
					var_route_handle.clone(),
					rt.new_string(
						(var_build_constants.array_get(rt.new_string('build_url'))).str() + 'routes/' + (var_route_shadow['name']).str() + '/route' + var_extension),
					if !(var_route_asset.array_get(rt.new_string('module_dependencies'))).is_null() {
						var_route_asset.array_get(rt.new_string('module_dependencies'))
					} else {
						rt.new_array()
					}, if !(var_route_asset.array_get(rt.new_string('version'))).is_null() {
						var_route_asset.array_get(rt.new_string('version'))
					} else {
						rt.new_bool(false)
					}])
			}
		}
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string(register_function_name),
		]))
		{
			rt.call_function('call_user_func', [rt.new_string(register_function_name),
				var_route_shadow['path'], var_content_handle.clone(),
				var_route_handle.clone()])
		}
	}
}

fn wp_register_options_connectors_page_routes() {
	mut var_wp_options_connectors_routes_data := rt.new_null()
	wp_register_page_routes(var_wp_options_connectors_routes_data.clone(),
		'wp_register_options_connectors_route')
}

fn wp_register_options_connectors_wp_admin_page_routes() {
	mut var_wp_options_connectors_routes_data := rt.new_null()
	wp_register_page_routes(var_wp_options_connectors_routes_data.clone(),
		'wp_register_options_connectors_wp_admin_route')
}

fn wp_register_font_library_page_routes() {
	mut var_wp_font_library_routes_data := rt.new_null()
	wp_register_page_routes(var_wp_font_library_routes_data.clone(),
		'wp_register_font_library_route')
}

fn wp_register_font_library_wp_admin_page_routes() {
	mut var_wp_font_library_routes_data := rt.new_null()
	wp_register_page_routes(var_wp_font_library_routes_data.clone(),
		'wp_register_font_library_wp_admin_route')
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_GLOBALS := rt.new_null()
	mut var_routes_file := rt.new_string(@DIR + '/routes/registry.php')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_routes_file.clone()])))))
	{
		return rt.new_null()
	}
	mut var_routes := rt.include_file(var_routes_file.to_string(), '3')
	mut var_routes_by_page := rt.new_array()
	mut iter_1 := var_routes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_route := item_1.val
		mut var_page_slug := var_route.array_get(rt.new_string('page'))
		if !(var_routes_by_page.array_isset(var_page_slug)) {
			var_routes_by_page.array_set(var_page_slug, rt.new_array())
		}
		var_routes_by_page.array_get_mut(var_page_slug).array_push(var_route.clone())
	}
	mut iter_2 := var_routes_by_page.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_page_routes := item_2.val
		mut var_page_slug := item_2.key
		mut var_page_slug_underscore := rt.call_function('str_replace', [
			rt.new_string('-'),
			rt.new_string('_'),
			var_page_slug.clone(),
		])
		mut var_global_name :=
			rt.new_string('wp_' + var_page_slug_underscore.str() + '_routes_data')
		var_GLOBALS.array_set(var_global_name, var_page_routes.clone())
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
