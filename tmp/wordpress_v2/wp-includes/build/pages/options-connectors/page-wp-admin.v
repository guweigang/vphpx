import rt

var_wp_options_connectors_wp_admin_routes = []rt.PhpVal{}
var_wp_options_connectors_wp_admin_menu_items = []rt.PhpVal{}
fn wp_register_options_connectors_wp_admin_route(var_path rt.PhpVal, var_content_module rt.PhpVal, var_route_module rt.PhpVal) {
	mut var_wp_options_connectors_wp_admin_routes := []rt.PhpVal{}
	mut var_route := map[string]rt.PhpVal{}
	var_route = {
		'path': var_path
	}
	if !(!rt.is_true(var_content_module)) {
		var_route['content_module'] = var_content_module.clone()
	}
	if !(!rt.is_true(var_route_module)) {
		var_route['route_module'] = var_route_module.clone()
	}
	var_wp_options_connectors_wp_admin_routes << var_route.clone()
}

fn wp_register_options_connectors_wp_admin_menu_item(var_id rt.PhpVal, var_label rt.PhpVal, var_to rt.PhpVal, parent_id string) {
	mut var_parent_id := parent_id
	mut var_wp_options_connectors_wp_admin_menu_items := []rt.PhpVal{}
	mut var_menu_item := map[string]rt.PhpVal{}
	var_menu_item = {
		'id':    var_id
		'label': var_label
		'to':    var_to
	}
	if !(parent_id == '') {
		var_menu_item['parent'] = rt.new_string(parent_id)
	}
	var_wp_options_connectors_wp_admin_menu_items << var_menu_item.clone()
}

fn wp_get_options_connectors_wp_admin_routes() rt.PhpVal {
	mut var_wp_options_connectors_wp_admin_routes := []rt.PhpVal{}
	return if !var_wp_options_connectors_wp_admin_routes.is_null() {
		var_wp_options_connectors_wp_admin_routes
	} else {
		[]rt.PhpVal{}
	}
}

fn wp_get_options_connectors_wp_admin_menu_items() rt.PhpVal {
	mut var_wp_options_connectors_wp_admin_menu_items := []rt.PhpVal{}
	return if !var_wp_options_connectors_wp_admin_menu_items.is_null() {
		var_wp_options_connectors_wp_admin_menu_items
	} else {
		[]rt.PhpVal{}
	}
}

fn wp_options_connectors_wp_admin_preload_data() {
	mut var_preload_paths := []rt.PhpVal{}
	mut var_preload_data := rt.new_null()
	var_preload_paths = [
		rt.new_string('/?_fields=description,gmt_offset,home,image_sizes,image_size_threshold,image_output_formats,jpeg_interlaced,png_interlaced,gif_interlaced,name,site_icon,site_icon_url,site_logo,timezone_string,url,page_for_posts,page_on_front,show_on_front'),
		[rt.new_string('/wp/v2/settings'), rt.new_string('OPTIONS')],
	]
	var_preload_data = rt.call_function('array_reduce', [
		rt.create_array_from_list(var_preload_paths),
		rt.new_string('rest_preload_api_request'),
		[]rt.PhpVal{},
	])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('sprintf', [
			rt.new_string('wp.apiFetch.use( wp.apiFetch.createPreloadingMiddleware( %s ) );'),
			rt.call_function('wp_json_encode', [var_preload_data.clone()]),
		]),
		rt.new_string('after')])
}

fn wp_options_connectors_wp_admin_enqueue_scripts(var_hook_suffix rt.PhpVal) {
	mut var_current_screen := rt.new_null()
	mut var_is_our_page := false
	mut var_build_constants := rt.new_null()
	mut var_routes := rt.new_null()
	mut var_asset_file := rt.new_null()
	mut var_asset := rt.new_null()
	mut var_init_js_function := ''
	mut var_style_dependencies := rt.new_null()
	mut var_boot_dependencies := []rt.PhpVal{}
	mut var_route := map[string]rt.PhpVal{}
	var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	var_is_our_page = rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('options-connectors-wp-admin'), rt.get_superglobal('_GET').array_get(rt.new_string('page'))))
		|| rt.is_true(var_current_screen)
		&& rt.is_true(rt.identical(rt.new_string('options-connectors'), rt.get_property(var_current_screen, 'id')))
	if !var_is_our_page {
		return
	}
	var_build_constants = rt.include_file(@DIR + '/../../constants.php', '3')
	rt.call_function('do_action', [rt.new_string('options-connectors-wp-admin_init')])
	wp_options_connectors_wp_admin_preload_data()
	var_routes = wp_get_options_connectors_wp_admin_routes()
	var_asset_file = rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/js/dist/script-modules/boot/index.min.asset.php')
	if rt.is_true(rt.call_function('file_exists', [var_asset_file.clone()])) {
		var_asset = rt.include_file(var_asset_file.to_string(), '3')
		rt.call_function('wp_register_script', [
			rt.new_string('options-connectors-wp-admin-prerequisites'),
			rt.new_string(''),
			var_asset.array_get(rt.new_string('dependencies')),
			var_asset.array_get(rt.new_string('version')),
			rt.new_bool(true),
		])
		var_init_js_function = '( mountId, routes ) => {\n\tconst run = async () => {\n\t\tconst mod = await import( "@wordpress/boot" );\n\t\tmod.initSinglePage( { mountId, routes } );\n\t};\n\tif ( document.readyState === "loading" ) {\n\t\tdocument.addEventListener( "DOMContentLoaded", run );\n\t} else {\n\t\trun();\n\t}\n}'
		rt.call_function('wp_add_inline_script', [
			rt.new_string('options-connectors-wp-admin-prerequisites'),
			rt.call_function('sprintf', [rt.new_string('( %s )( %s, %s );'),
				rt.new_string(var_init_js_function.str()).clone(),
				rt.call_function('wp_json_encode', [
					rt.new_string('options-connectors-wp-admin-app'),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				]),
				rt.call_function('wp_json_encode', [
					var_routes.clone(),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES')),
				])]),
		])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_handle := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return
		}
		var_style_dependencies = rt.call_function('array_filter', [
			var_asset.array_get(rt.new_string('dependencies')),
			rt.new_closure(closure_1_fn),
		])
		rt.call_function('wp_register_style', [
			rt.new_string('options-connectors-wp-admin-prerequisites'),
			rt.new_bool(false),
			var_style_dependencies.clone(),
			var_asset.array_get(rt.new_string('version')),
		])
		var_boot_dependencies = [
			[rt.new_string('static'), rt.new_string('@wordpress/boot')],
		]
		mut iter_1 := var_routes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_route_shadow := item_1.val
			if var_route_shadow.array_isset(rt.new_string('route_module')) {
				var_boot_dependencies << rt.create_array([
					rt.ArrayItem{ key: 'import', val: 'static' },
					rt.ArrayItem{ key: 'id', val: var_route_shadow['route_module'] },
				])
			}
			if var_route_shadow.array_isset(rt.new_string('content_module')) {
				var_boot_dependencies << rt.create_array([
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
					rt.ArrayItem{ key: 'id', val: var_route_shadow['content_module'] },
				])
			}
		}
		rt.call_function('wp_register_script_module', [
			rt.new_string('options-connectors-wp-admin'),
			rt.new_string(
				(var_build_constants.array_get(rt.new_string('build_url'))).str() + 'pages/options-connectors/loader.js'),
			rt.create_array_from_list(var_boot_dependencies),
		])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('options-connectors-wp-admin-prerequisites'),
		])
		rt.call_function('wp_enqueue_script_module', [
			rt.new_string('options-connectors-wp-admin'),
		])
		rt.call_function('wp_enqueue_style', [
			rt.new_string('options-connectors-wp-admin-prerequisites'),
		])
	}
}

fn wp_options_connectors_wp_admin_render_page() {
	// unsupported statement: Stmt_InlineHTML
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wp_options_connectors_wp_admin_routes :=
		rt.get_superglobal('wp_options_connectors_wp_admin_routes')
	mut var_wp_options_connectors_wp_admin_menu_items :=
		rt.get_superglobal('wp_options_connectors_wp_admin_menu_items')
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.new_string('wp_options_connectors_wp_admin_enqueue_scripts')])
}
