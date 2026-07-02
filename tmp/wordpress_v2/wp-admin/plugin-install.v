import rt

struct Class_WP_Plugin_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_plugin_dependencies(_args ...rt.PhpVal) &Class_WP_Plugin_Dependencies {
	mut obj := &Class_WP_Plugin_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Plugin_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Plugin_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_tab := rt.new_null()
	mut var_tabs := map[string]rt.PhpVal{}
	mut var_paged := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IFRAME_REQUEST')])))))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))
		&& rt.is_true(rt.identical(rt.new_string('plugin-information'), rt.get_superglobal('_GET').array_get(rt.new_string('tab')))) {
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
			rt.new_bool(true)])
	}
	rt.include_file(@DIR + '/admin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		rt.call_function('wp_die', [
			rt.call_function('__', [
				rt.new_string('Sorry, you are not allowed to install plugins on this site.'),
			]),
		])
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [
			rt.call_function('network_admin_url', [rt.new_string('plugin-install.php')]),
		])
		exit(0)
	}
	mut var_wp_list_table := rt.call_function('_get_list_table', [
		rt.new_string('WP_Plugin_Install_List_Table'),
	])
	mut var_pagenum := rt.call_method(var_wp_list_table, 'get_pagenum', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wp_http_referer')))) {
		mut var_location := rt.call_function('remove_query_arg', [
			rt.new_string('_wp_http_referer'),
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))]),
		])
		if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged')))) {
			var_location = rt.call_function('add_query_arg', [
				rt.new_string('paged'),
				rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged'))).to_i64()),
				var_location.clone()])
		}
		rt.call_function('wp_redirect', [var_location.clone()])
		exit(0)
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	mut var_total_pages := rt.call_method(var_wp_list_table, 'get_pagination_arg', [
		rt.new_string('total_pages'),
	])
	if rt.is_true(rt.greater(var_pagenum, var_total_pages))
		&& rt.is_true(rt.greater(var_total_pages, rt.new_int(0))) {
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('paged'),
				var_total_pages.clone()]),
		])
		exit(0)
	}
	mut var_title := rt.call_function('__', [rt.new_string('Add Plugins')])
	mut var_parent_file := 'plugins.php'
	rt.call_function('wp_enqueue_script', [rt.new_string('plugin-install')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('plugin-information'), var_tab)))) {
		rt.call_function('add_thickbox', []rt.PhpVal{})
	}
	mut var_body_id := var_tab
	rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
	rt.call_function('do_action', [
		rt.new_string('install_plugins_pre_${var_tab.to_string()}'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('upload'), var_tab)))) {
		rt.call_function('do_action', [rt.new_string('install_plugins_pre_upload')])
	}
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Overview'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Plugins hook into WordPress to extend its functionality with custom features. Plugins are developed independently from the core WordPress application by thousands of developers all over the world. All plugins in the official <a href="%s">WordPress Plugin Directory</a> are compatible with the license WordPress uses.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/plugins/')])])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can find new plugins to install by searching or browsing the directory right here in your own Plugins section.')])).str() +
				' <span id="live-search-desc" class="hide-if-no-js">' +
				(rt.call_function('__', [rt.new_string('The search results will be updated as you type.')])).str() +
				'</span></p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'adding-plugins' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Adding Plugins'),
			]) }, rt.ArrayItem{ key: 'content', val: '<p>' +
				(rt.call_function('__', [rt.new_string('If you know what you are looking for, Search is your best bet. The Search screen has options to search the WordPress Plugin Directory for a particular Term, Author, or Tag. You can also search the directory by selecting popular tags. Tags in larger type mean more plugins have been labeled with that tag.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If you just want to get an idea of what&#8217;s available, you can browse Featured and Popular plugins by using the links above the plugins list. These sections rotate regularly.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('You can also browse a user&#8217;s favorite plugins, by using the Favorites link above the plugins list and entering their WordPress.org username.')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('If you want to install a plugin that you&#8217;ve downloaded elsewhere, click the Upload Plugin button above the plugins list. You will be prompted to upload the .zip package, and once uploaded, you can activate the new plugin.')])).str() +
				'</p>' }]),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}), 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:')])).str() +
			'</strong></p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/documentation/article/plugins-add-new-screen/">Documentation on Installing Plugins</a>')])).str() +
			'</p>' + '<p>' +
			(rt.call_function('__', [rt.new_string('<a href="https://wordpress.org/support/forums/">Support forums</a>')])).str() +
			'</p>'),
	])
	rt.call_method(rt.call_function('get_current_screen', []rt.PhpVal{}),
		'set_screen_reader_content', [
		rt.create_array([
			rt.ArrayItem{ key: 'heading_views', val: rt.call_function('__', [
				rt.new_string('Filter plugins list'),
			]) },
			rt.ArrayItem{ key: 'heading_pagination', val: rt.call_function('__', [
				rt.new_string('Plugins list navigation'),
			]) },
			rt.ArrayItem{ key: 'heading_list', val: rt.call_function('__', [
				rt.new_string('Plugins list'),
			]) },
		]),
	])
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-header.php', '4')
	mut iife_temp_0 := Class_WP_Plugin_Dependencies{}
	mut iife_result_0 := iife_temp_0.initialize()
	mut iife_temp_1 := Class_WP_Plugin_Dependencies{}
	mut iife_result_1 := iife_temp_1.display_admin_notice_for_unmet_dependencies()
	mut iife_temp_2 := Class_WP_Plugin_Dependencies{}
	mut iife_result_2 := iife_temp_2.display_admin_notice_for_circular_dependencies()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('plugin-install-tab-${var_tab.to_string()}'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_tabs['upload']))
		&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('upload_plugins')])) {
		rt.call_function('printf', [
			rt.new_string(' <a href="%s" class="upload-view-toggle page-title-action"><span class="upload">%s</span><span class="browse">%s</span></a>'),
			if rt.is_true(rt.identical(rt.new_string('upload'), var_tab)) { rt.call_function('self_admin_url', [
					rt.new_string('plugin-install.php'),
				]) } else { rt.call_function('self_admin_url', [
					rt.new_string('plugin-install.php?tab=upload'),
				]) },
			rt.call_function('__', [
				rt.new_string('Upload Plugin'),
			]),
			rt.call_function('__', [
				rt.new_string('Browse Plugins'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('upload'), var_tab)))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('do_action', [rt.new_string('install_plugins_upload')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_method(var_wp_list_table, 'views', []rt.PhpVal{})
	}
	rt.call_function('do_action', [
		rt.new_string('install_plugins_${var_tab.to_string()}'),
		var_paged.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_request_filesystem_credentials_modal', []rt.PhpVal{})
	rt.call_function('wp_print_admin_notice_templates', []rt.PhpVal{})
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/admin-footer.php', '4')
}
