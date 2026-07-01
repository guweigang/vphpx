import rt

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
}

fn create_wp_block_editor_context() &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Editor_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_title := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_method(var_current_screen, 'is_block_editor', [rt.new_bool(true)])
	mut var_block_editor_context := create_wp_block_editor_context(rt.create_array([
		rt.ArrayItem{ key: 'name', val: 'core/edit-widgets' },
	]))
	mut var_preload_paths := [
		[
			rt.call_function('rest_get_route_for_post_type_items', [
				rt.new_string('attachment'),
			]),
			rt.new_string('OPTIONS'),
		],
		rt.new_string('/wp/v2/widget-types?context=edit&per_page=-1'),
		rt.new_string('/wp/v2/sidebars?context=edit&per_page=-1'),
		rt.new_string('/wp/v2/widgets?context=edit&per_page=-1&_embed=about'),
	]
	rt.call_function('block_editor_rest_api_preload', [var_preload_paths.dup(),
		var_block_editor_context])
	mut var_editor_settings := rt.call_function('get_block_editor_settings', [
		rt.call_function('array_merge', [
			rt.call_function('get_legacy_widget_block_editor_settings', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'styles', val: rt.call_function('get_block_editor_theme_styles',
					[]rt.PhpVal{}) },
			]),
		]),
		var_block_editor_context,
	])
	rt.call_function('remove_action', [rt.new_string('enqueue_block_editor_assets'),
		rt.new_string('wp_enqueue_editor_block_directory_assets')])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-edit-widgets'),
		rt.call_function('sprintf', [
			rt.new_string('wp.domReady( function() {\n\t\t\twp.editWidgets.initialize( "widgets-editor", %s );\n\t\t} );'),
			rt.call_function('wp_json_encode', [var_editor_settings.dup(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
		])])
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		'wp.blocks.unstable__bootstrapServerSideBlockDefinitions(' +
			(rt.call_function('wp_json_encode', [rt.call_function('get_block_editor_server_block_settings', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
			');'])
	mut var_registered_sources := rt.call_function('get_all_registered_block_bindings_sources',
		[]rt.PhpVal{})
	if !(!rt.is_true(var_registered_sources)) {
		mut var_filtered_sources := []rt.PhpVal{}
		{
			mut iter_1 := var_registered_sources.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_source := item_1.val
				var_filtered_sources << rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.get_property(var_source, 'name') },
					rt.ArrayItem{ key: 'label', val: rt.get_property(var_source, 'label') },
					rt.ArrayItem{ key: 'usesContext', val: rt.get_property(var_source,
						'uses_context') },
				])
			}
		}
		mut var_script := rt.call_function('sprintf', [
			rt.new_string('for ( const source of %s ) { wp.blocks.registerBlockBindingsSource( source ); }'),
			rt.call_function('wp_json_encode', [var_filtered_sources.dup(),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES'))]),
		])
		rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
			var_script.dup()])
	}
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-blocks'),
		rt.call_function('sprintf', [rt.new_string('wp.blocks.setCategories( %s );'),
			rt.call_function('wp_json_encode', [
				rt.call_function('get_block_categories', [var_block_editor_context]),
				rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
					rt.get_constant('JSON_UNESCAPED_SLASHES')),
			])]),
		rt.new_string('after')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-edit-widgets')])
	rt.call_function('wp_enqueue_script', [rt.new_string('admin-widgets')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-edit-widgets')])
	rt.call_function('do_action', [rt.new_string('enqueue_block_editor_assets')])
	rt.call_function('do_action', [rt.new_string('sidebar_admin_setup')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	rt.call_function('do_action', [rt.new_string('widgets_admin_page')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('file_exists', [
		(rt.get_constant('WP_PLUGIN_DIR')).str() + '/classic-widgets/classic-widgets.php',
	]))
	{
		mut var_installed := true
		mut var_plugin_activate_url := rt.call_function('wp_nonce_url', [
			rt.new_string('plugins.php?action=activate&amp;plugin=classic-widgets/classic-widgets.php'),
			rt.new_string('activate-plugin_classic-widgets/classic-widgets.php'),
		])
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The block widgets require JavaScript. Please enable JavaScript in your browser settings, or activate the <a href="%s">Classic Widgets plugin</a>.'),
			]),
			rt.call_function('esc_url', [
				var_plugin_activate_url.dup(),
			]),
		])
	} else {
		var_installed = false
		mut var_plugin_install_url := rt.call_function('wp_nonce_url', [
			rt.call_function('self_admin_url', [
				rt.new_string('update.php?action=install-plugin&plugin=classic-widgets'),
			]),
			rt.new_string('install-plugin_classic-widgets'),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The block widgets require JavaScript. Please enable JavaScript in your browser settings, or install the <a href="%s">Classic Widgets plugin</a>.'),
			]),
			rt.call_function('esc_url', [
				var_plugin_install_url.dup(),
			]),
		])
	}
	var_message = rt.call_function('apply_filters', [
		rt.new_string('block_widgets_no_javascript_message'),
		var_message.dup(),
		rt.new_bool(var_installed).dup(),
	])
	rt.call_function('wp_admin_notice', [var_message.dup(),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hide-if-js' },
			]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('sidebar_admin_page')])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
