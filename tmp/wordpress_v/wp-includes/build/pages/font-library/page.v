import rt

fn wp_register_font_library_route(var_path rt.PhpVal, var_content_module rt.PhpVal, var_route_module rt.PhpVal) {
	mut var_wp_font_library_routes := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_route := {
		'path': var_path
	}
	if !(!rt.is_true(var_content_module)) {
		var_route['content_module'] = var_content_module.dup()
	}
	if !(!rt.is_true(var_route_module)) {
		var_route['route_module'] = var_route_module.dup()
	}
	var_wp_font_library_routes << var_route.dup()
}

fn wp_register_font_library_menu_item(var_id rt.PhpVal, var_label rt.PhpVal, var_to rt.PhpVal, parent_id string, parent_type string) {
	mut var_wp_font_library_menu_items := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	mut var_menu_item := {
		'id':    var_id
		'label': var_label
		'to':    var_to
	}
	if !(parent_id == '') {
		var_menu_item['parent'] = rt.new_string(parent_id).dup()
	}
	if rt.is_true(rt.new_bool(!(parent_type == '')
		&& rt.is_true(rt.call_function('in_array', [rt.new_string(parent_type), rt.create_array([rt.ArrayItem{
		key: none
		val: 'drilldown'
	}, rt.ArrayItem{ key: none, val: 'dropdown' }]), rt.new_bool(true)]))))
	{
		var_menu_item['parent_type'] = rt.new_string(parent_type).dup()
	}
	var_wp_font_library_menu_items << var_menu_item.dup()
}

fn wp_get_font_library_routes() rt.PhpVal {
	mut var_wp_font_library_routes := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	return if !var_wp_font_library_routes.is_null() {
		var_wp_font_library_routes
	} else {
		[]rt.PhpVal{}
	}
}

fn wp_get_font_library_menu_items() rt.PhpVal {
	mut var_wp_font_library_menu_items := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	return if !var_wp_font_library_menu_items.is_null() {
		var_wp_font_library_menu_items
	} else {
		[]rt.PhpVal{}
	}
}

fn wp_font_library_preload_data() {
	mut var_preload_paths := [
		rt.new_string('/?_fields=description,gmt_offset,home,image_sizes,image_size_threshold,image_output_formats,jpeg_interlaced,png_interlaced,gif_interlaced,name,site_icon,site_icon_url,site_logo,timezone_string,url,page_for_posts,page_on_front,show_on_front'),
		[rt.new_string('/wp/v2/settings'), rt.new_string('OPTIONS')],
	]
	mut var_preload_data := rt.call_function('array_reduce', [
		var_preload_paths.dup(), rt.new_string('rest_preload_api_request'),
		[]rt.PhpVal{}])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-api-fetch'),
		rt.call_function('sprintf', [
			rt.new_string('wp.apiFetch.use( wp.apiFetch.createPreloadingMiddleware( %s ) );'),
			rt.call_function('wp_json_encode', [var_preload_data.dup()]),
		]),
		rt.new_string('after')])
}

fn wp_font_library_render_page() {
	mut var_build_constants := rt.include_file(@DIR + '/../../constants.php', '3')
	rt.call_function('set_current_screen', []rt.PhpVal{})
	rt.call_function('remove_action', [rt.new_string('admin_head'),
		rt.new_string('wp_admin_bar_header')])
	{
		mut iter_1 :=
			rt.get_property(rt.call_function('wp_scripts', []rt.PhpVal{}), 'queue').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_script := item_1.val
			rt.call_function('wp_dequeue_script', [var_script.dup()])
		}
	}
	{
		mut iter_1 :=
			rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_style := item_1.val
			rt.call_function('wp_dequeue_style', [var_style.dup()])
		}
	}
	rt.call_function('do_action', [rt.new_string('font-library_init')])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_enqueue_command_palette_assets'),
	]))
	{
		rt.call_function('wp_enqueue_command_palette_assets', []rt.PhpVal{})
	}
	wp_font_library_preload_data()
	mut var_menu_items := wp_get_font_library_menu_items()
	mut var_routes := wp_get_font_library_routes()
	mut var_asset_file := rt.new_string(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/js/dist/script-modules/boot/index.min.asset.php')
	if rt.is_true(rt.call_function('file_exists', [var_asset_file.dup()])) {
		mut var_asset := rt.include_file(var_asset_file.to_string(), '3')
		rt.call_function('wp_register_script', [
			rt.new_string('font-library-prerequisites'),
			rt.new_string(''),
			var_asset.array_get('dependencies'),
			var_asset.array_get('version'),
			rt.new_bool(true),
		])
		mut var_init_modules := []rt.PhpVal{}
		rt.call_function('wp_add_inline_script', [
			rt.new_string('font-library-prerequisites'),
			rt.call_function('sprintf', [
				rt.new_string('import("@wordpress/boot").then(mod => mod.init({mountId: "%s", menuItems: %s, routes: %s, initModules: %s, dashboardLink: "%s"}));'),
				rt.new_string('font-library-app'),
				rt.call_function('wp_json_encode', [var_menu_items.dup(),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
				rt.call_function('wp_json_encode', [var_routes.dup(),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
				rt.call_function('wp_json_encode', [var_init_modules.dup(),
					rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
						rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
				rt.call_function('esc_url', [rt.call_function('admin_url', [
					rt.new_string('/'),
				])]),
			]),
		])
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_handle := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return rt.call_function('wp_style_is', [var_handle.dup(),
				rt.new_string('registered')])
		}
		mut var_style_dependencies := rt.call_function('array_filter', [
			var_asset.array_get('dependencies'),
			rt.new_closure(closure_1_fn),
		])
		rt.call_function('wp_register_style', [
			rt.new_string('font-library-prerequisites'),
			rt.new_bool(false),
			var_style_dependencies.dup(),
			var_asset.array_get('version'),
		])
		mut var_boot_dependencies := [
			[rt.new_string('static'), rt.new_string('@wordpress/boot')],
		]
		{
			mut iter_1 := var_routes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_route := item_1.val
				if var_route.array_isset(rt.new_string('route_module')) {
					var_boot_dependencies << rt.create_array([
						rt.ArrayItem{ key: 'import', val: 'static' },
						rt.ArrayItem{ key: 'id', val: var_route.array_get('route_module') },
					])
				}
				if var_route.array_isset(rt.new_string('content_module')) {
					var_boot_dependencies << rt.create_array([
						rt.ArrayItem{ key: 'import', val: 'dynamic' },
						rt.ArrayItem{ key: 'id', val: var_route.array_get('content_module') },
					])
				}
			}
		}
		rt.call_function('wp_register_script_module', [rt.new_string('font-library'),
			(var_build_constants.array_get('build_url')).str() + 'pages/font-library/loader.js',
			var_boot_dependencies.dup()])
		rt.call_function('wp_enqueue_script', [
			rt.new_string('font-library-prerequisites'),
		])
		rt.call_function('wp_enqueue_script_module', [rt.new_string('font-library')])
		rt.call_function('wp_enqueue_style', [
			rt.new_string('font-library-prerequisites'),
		])
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('get_admin_page_title', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Global
	mut var_hook_suffix := 'font-library'
	rt.call_function('print_admin_styles', []rt.PhpVal{})
	rt.call_function('print_head_scripts', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('admin_head-${var_hook_suffix}')])
	rt.call_function('do_action', [rt.new_string('admin_head')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_footer'),
		rt.new_string('')])
	rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}), 'print_import_map',
		[]rt.PhpVal{})
	rt.call_function('print_footer_scripts', []rt.PhpVal{})
	rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}),
		'print_enqueued_script_modules', []rt.PhpVal{})
	rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}),
		'print_script_module_preloads', []rt.PhpVal{})
	rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}),
		'print_script_module_data', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('admin_footer-${var_hook_suffix}')])
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	// unsupported expression: Expr_Exit
}

fn wp_font_library_intercept_render() {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.identical(rt.new_string('font-library'), rt.get_superglobal('_GET').array_get('page')))))
	{
		wp_font_library_render_page()
		// unsupported expression: Expr_Exit
	}
}

pub fn init_wp_includes_build_pages_font_library_page_php() {
	// unsupported statement: Stmt_Global
	mut var_wp_font_library_routes := []rt.PhpVal{}
	mut var_wp_font_library_menu_items := []rt.PhpVal{}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('wp_font_library_intercept_render')])
}
