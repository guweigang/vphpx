import rt

struct Class_WC_Plugin_Updates {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_ActionScheduler_Versions {
	rt.PhpObjectBase
}

struct Class_ActionScheduler {
	rt.PhpObjectBase
}

fn create_wc_plugin_updates() &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants() &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions() &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler() &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Plugin_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Plugin_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Plugin_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler_Versions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler_Versions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_Versions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ActionScheduler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ActionScheduler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_views_html_admin_page_status_report_php() {
	mut var_wpdb := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	// unsupported statement: Stmt_Global
	mut var_report := rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_RestApiUtil.class()]), 'get_endpoint_data', [rt.new_string('/wc/v3/system_status')])
	mut var_environment := var_report.array_get('environment')
	mut var_database := var_report.array_get('database')
	mut var_post_type_counts := if var_report.array_isset(rt.new_string('post_type_counts')) { var_report.array_get('post_type_counts') } else { rt.new_array() }
	mut var_active_plugins := var_report.array_get('active_plugins')
	mut var_inactive_plugins := var_report.array_get('inactive_plugins')
	mut var_dropins_mu_plugins := var_report.array_get('dropins_mu_plugins')
	mut var_theme := var_report.array_get('theme')
	mut var_security := var_report.array_get('security')
	mut var_settings := var_report.array_get('settings')
	mut var_logging := var_report.array_get('logging')
	mut var_wp_pages := var_report.array_get('pages')
	mut var_plugin_updates := create_wc_plugin_updates()
	mut var_untested_plugins := var_plugin_updates.get_untested_plugins(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version'), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_Jetpack_Constants{}; return temp.get_constant(arg_0) }(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE')))
	mut var_active_plugins_count := if rt.is_true(rt.call_function('is_countable', [var_active_plugins.dup()])) { var_active_plugins.dup().array_count() } else { 0 }
	mut var_inactive_plugins_count := if rt.is_true(rt.call_function('is_countable', [var_inactive_plugins.dup()])) { var_inactive_plugins.dup().array_count() } else { 0 }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugin_data')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugin_path := rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/woocommerce/woocommerce.php')
	mut var_wc_version := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.call_function('file_exists', [var_plugin_path.dup()])) {
		mut var_plugin_data := rt.call_function('get_plugin_data', [var_plugin_path.dup()])
		var_wc_version = if !(var_plugin_data.array_get('Version')).is_null() { var_plugin_data.array_get('Version') } else { rt.new_string('') }
		// unsupported statement: Stmt_Nop
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Please copy and paste this information in your ticket when contacting support:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Get system report'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Understanding the status report'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Download for support'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy for support'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy for GitHub'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copying to clipboard failed. Please press Ctrl/Cmd+C to copy.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress environment'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress address (URL)'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('The root URL of your site.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_environment.array_get('site_url')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Site address (URL)'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('The homepage URL of your site.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_environment.array_get('home_url')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce version'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('The version of WooCommerce installed on your site.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if !(!rt.is_true(var_wc_version)) { var_wc_version } else { var_environment.array_get('version') }]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Legacy REST API package'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('The WooCommerce Legacy REST API plugin running on this site.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'legacy_rest_api_is_available', []rt.PhpVal{})) {
		var_plugin_path = rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Utilities_PluginUtil.class()]), 'get_wp_plugin_id', [rt.new_string('woocommerce-legacy-rest-api')])
		mut var_version := if !(rt.call_function('get_plugin_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin_path).str()]).array_get('Version')).is_null() { rt.call_function('get_plugin_data', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_plugin_path).str()]).array_get('Version') } else { rt.new_string('') }
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> ' + (rt.call_function('esc_html', [var_version.dup()])).str() + ' <code class="private">' + (rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'api'), 'get_rest_api_package_path', []rt.PhpVal{})])).str() + '</code></mark> ')
	} else {
		print('<mark class="info-icon"><span class="dashicons dashicons-info"></span> ' + (rt.call_function('esc_html__', [rt.new_string('The Legacy REST API plugin is not installed on this site.'), rt.new_string('woocommerce')])).str() + '</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Action Scheduler package'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Action Scheduler package running on your site.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler_Versions')])) && rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler')])))) {
		var_version = rt.call_method(fn () rt.PhpVal { mut temp := Class_ActionScheduler_Versions{}; return temp.instance() }(), 'latest_version', []rt.PhpVal{})
		mut var_path := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ActionScheduler{}; return temp.plugin_path(arg_0) }(rt.new_string(''))
		// unsupported statement: Stmt_Nop
	} else {
		var_version = rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_version.dup().is_null()))))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> ' + (rt.call_function('esc_html', [var_version.dup()])).str() + ' <code class="private">' + (rt.call_function('esc_html', [var_path.dup()])).str() + '</code></mark> ')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' + (rt.call_function('esc_html__', [rt.new_string('Unable to detect the Action Scheduler package.'), rt.new_string('woocommerce')])).str() + '</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Log directory writable'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('esc_html__', [rt.new_string('Several WooCommerce extensions can write logs which makes debugging problems easier. The directory must be writable for this to happen.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get('log_directory_writable')) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> <code class="private">' + (rt.call_function('esc_html', [.array_get()])).str() + '</code></mark> ')
	} else {
		rt.call_function('printf', [rt.new_string('<mark class="error"><span class="dashicons dashicons-warning"></span> %s</mark>'), rt.call_function('sprintf', [rt.call_function('esc_html__', [, ]),  + ])])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress version'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}
