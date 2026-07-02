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

struct Class_ {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_wc_plugin_updates(_args ...rt.PhpVal) &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler_versions(_args ...rt.PhpVal) &Class_ActionScheduler_Versions {
	mut obj := &Class_ActionScheduler_Versions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_actionscheduler(_args ...rt.PhpVal) &Class_ActionScheduler {
	mut obj := &Class_ActionScheduler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_(_args ...rt.PhpVal) &Class_ {
	mut obj := &Class_{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
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

fn (mut this Class_) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_report := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Utilities_RestApiUtil.class(),
	]), 'get_endpoint_data', [rt.new_string('/wc/v3/system_status')])
	mut var_environment := var_report.array_get(rt.new_string('environment'))
	mut var_database := var_report.array_get(rt.new_string('database'))
	mut var_post_type_counts := if var_report.array_isset(rt.new_string('post_type_counts')) {
		var_report.array_get(rt.new_string('post_type_counts'))
	} else {
		rt.new_array()
	}
	mut var_active_plugins := var_report.array_get(rt.new_string('active_plugins'))
	mut var_inactive_plugins := var_report.array_get(rt.new_string('inactive_plugins'))
	mut var_dropins_mu_plugins := var_report.array_get(rt.new_string('dropins_mu_plugins'))
	mut var_theme := var_report.array_get(rt.new_string('theme'))
	mut var_security := var_report.array_get(rt.new_string('security'))
	mut var_settings := var_report.array_get(rt.new_string('settings'))
	mut var_logging := var_report.array_get(rt.new_string('logging'))
	mut var_wp_pages := var_report.array_get(rt.new_string('pages'))
	mut var_plugin_updates := create_wc_plugin_updates()
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 :=
		iife_temp_0.get_constant(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE'))
	mut var_untested_plugins := var_plugin_updates.get_untested_plugins(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'version'), iife_result_0)
	mut var_active_plugins_count := if rt.call_function('is_countable', [
		var_active_plugins.clone()])
	{ var_active_plugins.clone().array_count() } else { 0 }
	mut var_inactive_plugins_count := if rt.call_function('is_countable', [
		var_inactive_plugins.clone()])
	{ var_inactive_plugins.clone().array_count() } else { 0 }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugin_data'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugin_path := rt.new_string(
		(rt.get_constant('WP_PLUGIN_DIR')).str() + '/woocommerce/woocommerce.php')
	mut var_wc_version := rt.new_string('')
	if rt.is_true(rt.call_function('file_exists', [var_plugin_path.clone()])) {
		mut var_plugin_data := rt.call_function('get_plugin_data', [
			var_plugin_path.clone()])
		var_wc_version = if !(var_plugin_data.array_get(rt.new_string('Version'))).is_null() {
			var_plugin_data.array_get(rt.new_string('Version'))
		} else {
			rt.new_string('')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Please copy and paste this information in your ticket when contacting support:'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Get system report'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Understanding the status report'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Download for support'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy for support'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied!'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy for GitHub'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Copying to clipboard failed. Please press Ctrl/Cmd+C to copy.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress environment'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress address (URL)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('The root URL of your site.'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('site_url'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Site address (URL)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('The homepage URL of your site.'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('home_url'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The version of WooCommerce installed on your site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if !(!rt.is_true(var_wc_version)) {
		var_wc_version
	} else {
		var_environment.array_get(rt.new_string('version'))
	}]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce Legacy REST API package'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The WooCommerce Legacy REST API plugin running on this site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'legacy_rest_api_is_available', []rt.PhpVal{}))
	{
		var_plugin_path = rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Utilities_PluginUtil.class(),
		]), 'get_wp_plugin_id', [rt.new_string('woocommerce-legacy-rest-api')])
		mut var_version := if !(rt.call_function('get_plugin_data', [
			rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_path.str()),
		]).array_get(rt.new_string('Version'))).is_null() { rt.call_function('get_plugin_data', [
				rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_path.str()),
			]).array_get(rt.new_string('Version')) } else { rt.new_string('') }
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> ' +
			(rt.call_function('esc_html', [var_version.clone()])).str() +
			' <code class="private">' +
			(rt.call_function('esc_html', [rt.call_method(rt.get_property(rt.call_function('wc', []rt.PhpVal{}), 'api'), 'get_rest_api_package_path', []rt.PhpVal{})])).str() +
			'</code></mark> ')
	} else {
		print('<mark class="info-icon"><span class="dashicons dashicons-info"></span> ' +
			(rt.call_function('esc_html__', [rt.new_string('The Legacy REST API plugin is not installed on this site.'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Action Scheduler package'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Action Scheduler package running on your site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler_Versions')]))
		&& rt.is_true(rt.call_function('class_exists', [rt.new_string('ActionScheduler')])) {
		mut iife_temp_1 := Class_ActionScheduler_Versions{}
		mut iife_result_1 := iife_temp_1.instance()
		var_version = rt.call_method(iife_result_1, 'latest_version', []rt.PhpVal{})
		mut iife_temp_2 := Class_ActionScheduler{}
		mut iife_result_2 := iife_temp_2.plugin_path(rt.new_string(''))
		mut var_path := iife_result_2
	} else {
		var_version = rt.new_null()
	}
	if !(var_version.clone().is_null()) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span> ' +
			(rt.call_function('esc_html', [var_version.clone()])).str() +
			' <code class="private">' + (rt.call_function('esc_html', [var_path.clone()])).str() +
			'</code></mark> ')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('esc_html__', [rt.new_string('Unable to detect the Action Scheduler package.'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Log directory writable'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Several WooCommerce extensions can write logs which makes debugging problems easier. The directory must be writable for this to happen.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('log_directory_writable'))) {
		print(
			'<mark class="yes"><span class="dashicons dashicons-yes"></span> <code class="private">' +
			(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('log_directory'))])).str() +
			'</code></mark> ')
	} else {
		rt.call_function('printf', [
			rt.new_string('<mark class="error"><span class="dashicons dashicons-warning"></span> %s</mark>'),
			rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('To allow logging, make %s writable.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('<code>' +
					(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('log_directory'))])).str() +
					'</code>'),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The version of WordPress installed on your site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_latest_version := rt.call_function('get_transient', [
		rt.new_string('woocommerce_system_status_wp_version_check'),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_latest_version)) {
		mut var_version_check := rt.call_function('wp_remote_get', [
			rt.new_string('https://api.wordpress.org/core/version-check/1.7/'),
		])
		mut var_api_response := rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_version_check.clone()]),
			rt.new_bool(true),
		])
		if rt.is_true(var_api_response) && var_api_response.array_isset(rt.new_string('offers'))
			&& var_api_response.array_get(rt.new_string('offers')).array_isset(rt.new_int(0))
			&& var_api_response.array_get(rt.new_string('offers')).array_get(rt.new_int(0)).array_isset(rt.new_string('version')) {
			var_latest_version =
				var_api_response.array_get(rt.new_string('offers')).array_get(rt.new_int(0)).array_get(rt.new_string('version'))
		} else {
			var_latest_version = var_environment.array_get(rt.new_string('wp_version'))
		}
		rt.call_function('set_transient', [
			rt.new_string('woocommerce_system_status_wp_version_check'),
			var_latest_version.clone(),
			rt.get_constant('DAY_IN_SECONDS'),
		])
	}
	if rt.is_true(rt.call_function('version_compare', [
		var_environment.array_get(rt.new_string('wp_version')),
		var_latest_version.clone(),
		rt.new_string('<'),
	]))
	{
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s - There is a newer version of WordPress available (%2$s)'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_environment.array_get(rt.new_string('wp_version'))]), rt.call_function('esc_html', [var_latest_version.clone()])])).str() +
			'</mark>')
	} else {
		print('<mark class="yes">' +
			(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('wp_version'))])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress multisite'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Whether or not you have WordPress Multisite enabled.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_environment.array_get(rt.new_string('wp_multisite'))) {
		'<span class="dashicons dashicons-yes"></span>'
	} else {
		'&ndash;'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress memory limit'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The maximum amount of memory (RAM) that your site can use at one time.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.less(var_environment.array_get(rt.new_string('wp_memory_limit')),
		rt.new_int(67108864)))
	{
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s - We recommend setting memory to at least 64MB. See: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.call_function('size_format', [var_environment.array_get(rt.new_string('wp_memory_limit'))])]), rt.new_string('<a href="https://wordpress.org/support/article/editing-wp-config-php/#increasing-memory-allocated-to-php" target="_blank">' + (rt.call_function('esc_html__', [rt.new_string('Increasing memory allocated to PHP'), rt.new_string('woocommerce')])).str() +
			'</a>')])).str() + '</mark>')
	} else {
		print('<mark class="yes">' +
			(rt.call_function('esc_html', [rt.call_function('size_format', [var_environment.array_get(rt.new_string('wp_memory_limit'))])])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress debug mode'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Displays whether or not WordPress is in Debug Mode.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('wp_debug_mode'))) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WordPress cron'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Displays whether or not WP Cron Jobs are enabled.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('wp_cron'))) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Environment type'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The current environment type set for this site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_environment.array_get(rt.new_string('wp_environment_type')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Language'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The current language used by WordPress. Default = English'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('language'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('External object cache'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Displays whether or not WordPress is using an external object cache.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('external_object_cache'))) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Server environment'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Server info'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Information about the web server that is currently hosting your site.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html',
		[var_environment.array_get(rt.new_string('server_info'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Server architecture'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Information about the operating system your server is running.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if !(!rt.is_true(var_environment.array_get(rt.new_string('server_architecture')))) { rt.call_function('esc_html', [
			var_environment.array_get(rt.new_string('server_architecture')),
		]) } else { rt.call_function('esc_html__', [
			rt.new_string('Unable to determine server architecture.  Please ask your hosting provider for this information.'),
			rt.new_string('woocommerce'),
		]) })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('PHP version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The version of PHP installed on your hosting server.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print('<mark class="yes">' +
		(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('php_version'))])).str() +
		'</mark>')
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('ini_get')])) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('PHP post max size'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The largest filesize that can be contained in one post.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('size_format', [
				var_environment.array_get(rt.new_string('php_post_max_size')),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('PHP time limit'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The amount of time (in seconds) that your site will spend on a single operation before timing out (to avoid server lockups)'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_environment.array_get(rt.new_string('php_max_execution_time')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('PHP max input vars'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The maximum number of variables your server can use for a single function to avoid overloads.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_environment.array_get(rt.new_string('php_max_input_vars')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('cURL version'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The version of cURL installed on your server.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_environment.array_get(rt.new_string('curl_version')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('SUHOSIN installed'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('Suhosin is an advanced protection system for PHP installations. It was designed to protect your servers on the one hand against a number of well known problems in PHP applications and on the other hand against potential unknown vulnerabilities within these applications or the PHP core itself. If enabled on your server, Suhosin may need to be configured to increase its data submission limits.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		print(if rt.is_true(var_environment.array_get(rt.new_string('suhosin_installed'))) {
			'<span class="dashicons dashicons-yes"></span>'
		} else {
			'&ndash;'
		})
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('mysql_version'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('MySQL version'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The version of MySQL installed on your hosting server.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('version_compare', [var_environment.array_get(rt.new_string('mysql_version')), rt.new_string('5.6'), rt.new_string('<')]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('strstr', [var_environment.array_get(rt.new_string('mysql_version_string')), rt.new_string('MariaDB')]))))) {
			print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s - We recommend a minimum MySQL version of 5.6. See: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_environment.array_get(rt.new_string('mysql_version_string'))]), rt.new_string('<a href="https://wordpress.org/about/requirements/" target="_blank">' + (rt.call_function('esc_html__', [rt.new_string('WordPress requirements'), rt.new_string('woocommerce')])).str() +
				'</a>')])).str() + '</mark>')
		} else {
			print('<mark class="yes">' +
				(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('mysql_version_string'))])).str() +
				'</mark>')
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Max upload size'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The largest filesize that can be uploaded to your WordPress installation.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('size_format',
			[var_environment.array_get(rt.new_string('max_upload_size'))]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Default timezone is UTC'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The default timezone for your server.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('UTC'),
		var_environment.array_get(rt.new_string('default_timezone'))))))
	{
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Default timezone is %s - it should be UTC'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_environment.array_get(rt.new_string('default_timezone'))])])).str() +
			'</mark>')
	} else {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('fsockopen/cURL'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Payment gateways can use cURL to communicate with remote servers to authorize payments, other plugins may also use it when communicating with remote services.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('fsockopen_or_curl_enabled'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('esc_html__', [rt.new_string('Your server does not have fsockopen or cURL enabled - PayPal IPN and other scripts which communicate with other servers will not work. Contact your hosting provider.'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('SoapClient'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Some webservices like shipping use SOAP to get information from remote servers, for example, live shipping quotes from FedEx require SOAP to be installed.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('soapclient_enabled'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your server does not have the %s class enabled - some gateway plugins which use SOAP may not work as expected.'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://php.net/manual/en/class.soapclient.php">SoapClient</a>')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('DOMDocument'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('HTML/Multipart emails use DOMDocument to generate inline CSS in templates.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('domdocument_enabled'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your server does not have the %s class enabled - HTML/Multipart emails, and also some extensions, will not work without DOMDocument.'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://php.net/manual/en/class.domdocument.php">DOMDocument</a>')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('GZip'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('GZip (gzopen) is used to open the GEOIP database from MaxMind.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('gzip_enabled'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your server does not support the %s function - this is required to use the GeoIP database from MaxMind.'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://php.net/manual/en/zlib.installation.php">gzopen</a>')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Multibyte string'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Multibyte String (mbstring) is used to convert character encoding, like for emails or converting characters to lowercase.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('mbstring_enabled'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Your server does not support the %s functions - this is required for better character encoding. Some fallbacks will be used instead for it.'), rt.new_string('woocommerce')]), rt.new_string('<a href="https://php.net/manual/en/mbstring.installation.php">mbstring</a>')])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remote post'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('PayPal uses this method of communicating when sending back transaction information.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('remote_post_successful'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s failed. Contact your hosting provider.'), rt.new_string('woocommerce')]), rt.new_string('wp_remote_post()')])).str() +
			' ' +
			(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('remote_post_response'))])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remote get'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('WooCommerce plugins may use this method of communication when checking for plugin updates.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_environment.array_get(rt.new_string('remote_get_successful'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s failed. Contact your hosting provider.'), rt.new_string('woocommerce')]), rt.new_string('wp_remote_get()')])).str() +
			' ' +
			(rt.call_function('esc_html', [var_environment.array_get(rt.new_string('remote_get_response'))])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	mut var_rows := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_system_status_environment_rows'),
		rt.new_array(),
	])
	mut iter_1 := var_rows.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		if !(!rt.is_true(var_row.array_get(rt.new_string('success')))) {
			mut var_css_class := 'yes'
			mut var_icon := '<span class="dashicons dashicons-yes"></span>'
		} else {
			var_css_class = 'error'
			var_icon = '<span class="dashicons dashicons-no-alt"></span>'
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_row.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_row.array_get(rt.new_string('name'))]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [if var_row.array_isset(rt.new_string('help')) {
			var_row.array_get(rt.new_string('help'))
		} else {
			rt.new_string('')
		}]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(var_css_class.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.new_string(var_icon.str()).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_data', [if !(!rt.is_true(var_row.array_get(rt.new_string('note')))) {
			var_row.array_get(rt.new_string('note'))
		} else {
			rt.new_string('')
		}]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Database'),
		rt.new_string('woocommerce')])
	mut iife_temp_3 := Class_{}
	mut iife_result_3 := iife_temp_3.output_tables_info()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce database version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The database version for WooCommerce. This should be the same as your WooCommerce version.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_database.array_get(rt.new_string('wc_database_version')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Database prefix'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_database.array_get(rt.new_string('database_prefix')).to_string().len > 20 {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%1$s - We recommend using a prefix with less than 20 characters. See: %2$s'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_database.array_get(rt.new_string('database_prefix'))]), rt.new_string('<a href="https://woocommerce.com/document/completed-order-email-doesnt-contain-download-links/#section-2" target="_blank">' + (rt.call_function('esc_html__', [rt.new_string('How to update your database table prefix'), rt.new_string('woocommerce')])).str() +
			'</a>')])).str() + '</mark>')
	} else {
		print('<mark class="yes">' +
			(rt.call_function('esc_html', [var_database.array_get(rt.new_string('database_prefix'))])).str() +
			'</mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_database.array_get(rt.new_string('database_size'))))
		&& !(!rt.is_true(var_database.array_get(rt.new_string('database_tables')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Total Database Size'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('%.2fMB'),
			rt.call_function('esc_html', [
				rt.add(var_database.array_get(rt.new_string('database_size')).array_get(rt.new_string('data')),
					var_database.array_get(rt.new_string('database_size')).array_get(rt.new_string('index'))),
			])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Database Data Size'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('%.2fMB'),
			rt.call_function('esc_html',
				[var_database.array_get(rt.new_string('database_size')).array_get(rt.new_string('data'))])])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Database Index Size'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('%.2fMB'),
			rt.call_function('esc_html',
				[var_database.array_get(rt.new_string('database_size')).array_get(rt.new_string('index'))])])
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 :=
			var_database.array_get(rt.new_string('database_tables')).array_get(rt.new_string('woocommerce')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_table_data := item_2.val
			mut var_table := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_table.clone()]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!(rt.is_true(var_table_data)))) {
				print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
					(rt.call_function('esc_html__', [rt.new_string('Table does not exist'), rt.new_string('woocommerce')])).str() +
					'</mark>')
			} else {
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Data: %1$.2fMB + Index: %2$.2fMB + Engine %3$s'),
						rt.new_string('woocommerce'),
					]),
					rt.call_function('esc_html', [
						rt.call_function('wc_format_decimal', [
							var_table_data.array_get(rt.new_string('data')),
							rt.new_int(2),
						]),
					]),
					rt.call_function('esc_html', [
						rt.call_function('wc_format_decimal', [
							var_table_data.array_get(rt.new_string('index')),
							rt.new_int(2),
						]),
					]),
					rt.call_function('esc_html', [
						var_table_data.array_get(rt.new_string('engine')),
					]),
				])
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		mut iter_3 :=
			var_database.array_get(rt.new_string('database_tables')).array_get(rt.new_string('other')).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_table_data := item_3.val
			mut var_table := item_3.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_table.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [
					rt.new_string('Data: %1$.2fMB + Index: %2$.2fMB + Engine %3$s'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					rt.call_function('wc_format_decimal', [
						var_table_data.array_get(rt.new_string('data')),
						rt.new_int(2),
					]),
				]),
				rt.call_function('esc_html', [
					rt.call_function('wc_format_decimal', [
						var_table_data.array_get(rt.new_string('index')),
						rt.new_int(2),
					]),
				]),
				rt.call_function('esc_html', [
					var_table_data.array_get(rt.new_string('engine')),
				]),
			])
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Database information:'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Unable to retrieve database information. Usually, this is not a problem, and it only means that your install is using a class that replaces the WordPress database class (e.g., HyperDB) and WooCommerce is unable to get database information.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_type_counts) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Post Type Counts'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_4 := var_post_type_counts.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_ptype := item_4.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_ptype.array_get(rt.new_string('type')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('absint', [var_ptype.array_get(rt.new_string('count'))]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Security'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Secure connection (HTTPS)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Is the connection to your store secure?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_security.array_get(rt.new_string('secure_connection'))) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your store is not using HTTPS. <a href="%s" target="_blank">Learn more about HTTPS and SSL Certificates</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://woocommerce.com/document/ssl-and-https/'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Hide errors from visitors'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Error messages can contain sensitive information about your store environment. These should be hidden from untrusted visitors.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_security.array_get(rt.new_string('hide_errors'))) {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Error messages should not be shown to visitors.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_active_plugins_count).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Active plugins'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_active_plugins_count).clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_4 := Class_{}
	mut iife_result_4 := iife_temp_4.output_plugins_info(var_active_plugins.clone(),
		var_untested_plugins.clone())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_inactive_plugins_count).clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Inactive plugins'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_inactive_plugins_count).clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_5 := Class_{}
	mut iife_result_5 := iife_temp_5.output_plugins_info(var_inactive_plugins.clone(),
		var_untested_plugins.clone())
	// unsupported statement: Stmt_InlineHTML
	mut var_dropins_count := if rt.call_function('is_countable', [
		var_dropins_mu_plugins.array_get(rt.new_string('dropins')),
	])
	{ var_dropins_mu_plugins.array_get(rt.new_string('dropins')).array_count() } else { 0 }
	if 0 < var_dropins_count {
		// unsupported statement: Stmt_InlineHTML
		rt.new_int(var_dropins_count)
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Dropin Plugins'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.new_int(var_dropins_count)
		// unsupported statement: Stmt_InlineHTML
		mut iter_5 := var_dropins_mu_plugins.array_get(rt.new_string('dropins')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_dropin := item_5.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				var_dropin.array_get(rt.new_string('plugin')),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [
				var_dropin.array_get(rt.new_string('name')),
			]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	mut var_mu_plugins_count := if rt.call_function('is_countable', [
		var_dropins_mu_plugins.array_get(rt.new_string('mu_plugins')),
	])
	{ var_dropins_mu_plugins.array_get(rt.new_string('mu_plugins')).array_count() } else { 0 }
	if 0 < var_mu_plugins_count {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_mu_plugins_count).clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Must Use Plugins'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_int(var_mu_plugins_count).clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_6 := var_dropins_mu_plugins.array_get(rt.new_string('mu_plugins')).iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_mu_plugin := item_6.val
			mut var_plugin_name := rt.call_function('esc_html', [
				var_mu_plugin.array_get(rt.new_string('name')),
			])
			if !(!rt.is_true(var_mu_plugin.array_get(rt.new_string('url')))) {
				var_plugin_name = rt.new_string('<a href="' +
					(rt.call_function('esc_url', [var_mu_plugin.array_get(rt.new_string('url'))])).str() +
					'" aria-label="' +
					(rt.call_function('esc_attr__', [rt.new_string('Visit plugin homepage'), rt.new_string('woocommerce')])).str() +
					'" target="_blank">' + var_plugin_name.str() + '</a>')
			}
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('wp_kses_post', [var_plugin_name.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('printf', [
				rt.call_function('esc_html__', [rt.new_string('by %s'),
					rt.new_string('woocommerce')]),
				rt.call_function('esc_html',
					[var_mu_plugin.array_get(rt.new_string('author_name'))]),
			])
			print(' &ndash; ' +(rt.call_function('esc_html', [var_mu_plugin.array_get(rt.new_string('version'))])).str())
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Settings'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Legacy API enabled'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Does your site have the Legacy REST API enabled?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_settings.array_get(rt.new_string('api_enabled'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Force SSL'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Does your site force a SSL Certificate for transactions?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_settings.array_get(rt.new_string('force_ssl'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Currency'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('What currency prices are listed at in the catalog and which currency gateways will take payments in.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_settings.array_get(rt.new_string('currency'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('currency_symbol')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Currency position'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The position of the currency symbol.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('currency_position')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thousand separator'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The thousand separator of displayed prices.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('thousand_separator')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Decimal separator'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The decimal separator of displayed prices.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('decimal_separator')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Number of decimals'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The number of decimal points shown in displayed prices.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('number_of_decimals')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Taxonomies: Product types'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('A list of taxonomy terms that can be used in regard to order/product statuses.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	mut var_display_terms := rt.new_array()
	mut iter_7 := var_settings.array_get(rt.new_string('taxonomies')).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_name := item_7.val
		mut var_slug := item_7.key
		var_display_terms << var_name.clone().to_string().to_lower() + ' (' + var_slug.str() + ')'
	}
	rt.echo_val(rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_map', [rt.new_string('esc_html'),
			rt.create_array_from_list(var_display_terms)])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Taxonomies: Product visibility'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('A list of taxonomy terms used for product visibility.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	var_display_terms = rt.new_array()
	mut iter_8 := var_settings.array_get(rt.new_string('product_visibility_terms')).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_name := item_8.val
		mut var_slug := item_8.key
		var_display_terms << var_name.clone().to_string().to_lower() + ' (' + var_slug.str() + ')'
	}
	rt.echo_val(rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_map', [rt.new_string('esc_html'),
			rt.create_array_from_list(var_display_terms)])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Connected to WooCommerce.com'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Is your site connected to WooCommerce.com?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('yes'),
		var_settings.array_get(rt.new_string('woocommerce_com_connected'))))
	{
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Enforce Approved Product Download Directories'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Is your site enforcing the use of Approved Product Download Directories?'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_settings.array_get(rt.new_string('enforce_approved_download_dirs'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('HPOS enabled:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('Is HPOS enabled?'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_settings.array_get(rt.new_string('HPOS_enabled'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Order datastore:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Datastore currently in use for orders.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_settings.array_get(rt.new_string('order_datastore')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('HPOS data sync enabled:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('Is data sync enabled for HPOS?'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_settings.array_get(rt.new_string('HPOS_sync_enabled'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled features:'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Features that are currently enabled.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('implode', [rt.new_string(', '),
			var_settings.array_get(rt.new_string('enabled_features'))]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Logging'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enabled'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('Is logging enabled?'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(var_logging.array_get(rt.new_string('logging_enabled'))) {
		'<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>'
	} else {
		'<mark class="no">&ndash;</mark>'
	})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Handler'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('How log entries are being stored.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_logging.array_get(rt.new_string('default_handler')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Retention period'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('How many days log entries will be kept before being auto-deleted.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html', [
			rt.call_function('_n', [rt.new_string('%s day'), rt.new_string('%s days'),
				var_logging.array_get(rt.new_string('retention_period_days')),
				rt.new_string('woocommerce')]),
		]),
		rt.call_function('esc_html', [
			rt.call_function('number_format_i18n', [
				var_logging.array_get(rt.new_string('retention_period_days')),
			]),
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Level threshold'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The minimum severity level of logs that will be stored.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.is_true(var_logging.array_get(rt.new_string('level_threshold'))) { rt.call_function('esc_html', [
			var_logging.array_get(rt.new_string('level_threshold')),
		]) } else { rt.new_string('<mark class="no">&ndash;</mark>') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Log directory size'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The total size of the files in the log directory.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		var_logging.array_get(rt.new_string('log_directory_size')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce pages'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_alt := 1
	mut iter_9 := var_wp_pages.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var__page := item_9.val
		mut var_found_error := false
		if rt.is_true(var__page.array_get(rt.new_string('page_id'))) {
			mut var_page_name := rt.new_string('<a href="' +
				(rt.call_function('get_edit_post_link', [var__page.array_get(rt.new_string('page_id'))])).str() +
				'" aria-label="' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Edit %s page'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('page_name'))])])).str() +
				'">' +
				(rt.call_function('esc_html', [var__page.array_get(rt.new_string('page_name'))])).str() +
				'</a>')
		} else {
			var_page_name = rt.call_function('esc_html', [
				var__page.array_get(rt.new_string('page_name')),
			])
		}
		print('<tr><td data-export-label="' +
			(rt.call_function('esc_attr', [var_page_name.clone()])).str() + '">' +
			(rt.call_function('wp_kses_post', [var_page_name.clone()])).str() + ':</td>')
		print('<td class="help">' +
			(rt.call_function('wc_help_tip', [rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('The URL of your %s page (along with the Page ID).'), rt.new_string('woocommerce')]), var_page_name.clone()])])).str() +
			'</td><td>')
		if rt.is_true(rt.new_bool(!(rt.is_true(var__page.array_get(rt.new_string('page_set')))))) {
			print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
				(rt.call_function('esc_html__', [rt.new_string('Page not set'), rt.new_string('woocommerce')])).str() +
				'</mark>')
			var_found_error = true
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var__page.array_get(rt.new_string('page_exists')))))) {
			print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
				(rt.call_function('esc_html__', [rt.new_string('Page ID is set, but the page does not exist'), rt.new_string('woocommerce')])).str() +
				'</mark>')
			var_found_error = true
		} else if rt.is_true(rt.new_bool(!(rt.is_true(var__page.array_get(rt.new_string('page_visible')))))) {
			print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
				(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Page visibility should be <a href="%s" target="_blank">public</a>'), rt.new_string('woocommerce')]), rt.new_string('https://wordpress.org/support/article/content-visibility/')])])).str() +
				'</mark>')
			var_found_error = true
		} else if rt.is_true(var__page.array_get(rt.new_string('shortcode_required')))
			|| rt.is_true(var__page.array_get(rt.new_string('block_required'))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(var__page.array_get(rt.new_string('shortcode_present'))))))
				&& rt.is_true(rt.new_bool(!(rt.is_true(var__page.array_get(rt.new_string('block_present')))))) {
				print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
					(if rt.is_true(var__page.array_get(rt.new_string('block_required'))) { rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Page does not contain the %1$s shortcode or the %2$s block.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('shortcode'))]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('block'))])]) } else { rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Page does not contain the %s shortcode.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('shortcode'))])]) }).str() +
					'</mark>')
				var_found_error = true
			}
			if rt.is_true(var__page.array_get(rt.new_string('shortcode_present')))
				&& rt.is_true(var__page.array_get(rt.new_string('block_present'))) {
				print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
					(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('Page contains both the %1$s shortcode and the %2$s block.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('shortcode'))]), rt.call_function('esc_html', [var__page.array_get(rt.new_string('block'))])])).str() +
					'</mark>')
				var_found_error = true
			}
		}
		if !var_found_error {
			mut var_additional_info := rt.new_string('')
			if !(!rt.is_true(var__page.array_get(rt.new_string('shortcode'))))
				|| !(!rt.is_true(var__page.array_get(rt.new_string('block')))) {
				mut iife_temp_6 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
				mut iife_result_6 :=
					iife_temp_6.is_overriden_by_custom_template_content(var__page.array_get(rt.new_string('block')))
				if rt.is_true(iife_result_6) {
					var_additional_info = rt.call_function('__', [
						rt.new_string("This page's content is overridden by custom template content"),
						rt.new_string('woocommerce'),
					])
				} else if rt.is_true(var__page.array_get(rt.new_string('shortcode_present'))) {
					mut var_shortcode_display := var__page.array_get(rt.new_string('shortcode'))
					if rt.is_true(var_shortcode_display)
						&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('['), var_shortcode_display.array_get(rt.new_int(0)))))) {
						var_shortcode_display = rt.new_string('[' + var_shortcode_display.str() +
							']')
					}
					var_additional_info = rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Contains the <strong>%1$s</strong> shortcode'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('esc_html', [
							var_shortcode_display.clone(),
						]),
					])
				} else if rt.is_true(var__page.array_get(rt.new_string('block_present'))) {
					var_additional_info = rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Contains the <strong>%1$s</strong> block'),
							rt.new_string('woocommerce'),
						]),
						rt.call_function('esc_html', [
							var__page.array_get(rt.new_string('block')),
						]),
					])
				}
				if !(!rt.is_true(var_additional_info)) {
					var_additional_info = rt.new_string('<mark class="no"> -
						<span class="dashicons dashicons-info"></span> ' +
						var_additional_info.str() + '</mark>')
				}
			}
			print('<mark class="yes">#' +
				(rt.call_function('absint', [var__page.array_get(rt.new_string('page_id'))])).str() +
				' - ' +
				(rt.call_function('esc_html', [rt.call_function('str_replace', [rt.call_function('home_url', []rt.PhpVal{}), rt.new_string(''), rt.call_function('get_permalink', [var__page.array_get(rt.new_string('page_id'))])])])).str() +
				'</mark>' + var_additional_info.str())
		}
		print('</td></tr>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Theme'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The name of the current active theme.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_theme.array_get(rt.new_string('name'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Version'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('The installed version of the current active theme.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('version_compare', [
		var_theme.array_get(rt.new_string('version')),
		var_theme.array_get(rt.new_string('version_latest')),
		rt.new_string('<'),
	]))
	{
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s (update to version %2$s is available)'),
					rt.new_string('woocommerce'),
				]),
				var_theme.array_get(rt.new_string('version')),
				var_theme.array_get(rt.new_string('version_latest')),
			]),
		]))
	} else {
		rt.echo_val(rt.call_function('esc_html', [var_theme.array_get(rt.new_string('version'))]))
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Author URL'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [rt.new_string('The theme developers URL.'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_theme.array_get(rt.new_string('author_url'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Child theme'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Displays whether or not the current theme is a child theme.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_theme.array_get(rt.new_string('is_child_theme'))) {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	} else {
		print('<span class="dashicons dashicons-no-alt"></span> &ndash; ' +(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you are modifying WooCommerce on a parent theme that you did not build personally we recommend using a child theme. See: <a href="%s" target="_blank">How to create a child theme</a>'), rt.new_string('woocommerce')]), rt.new_string('https://developer.wordpress.org/themes/advanced-topics/child-themes/')])])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_theme.array_get(rt.new_string('is_child_theme'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Parent theme name'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The name of the parent theme.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_theme.array_get(rt.new_string('parent_name')),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Parent theme version'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The installed version of the parent theme.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_theme.array_get(rt.new_string('parent_version')),
		]))
		if rt.is_true(rt.call_function('version_compare', [
			var_theme.array_get(rt.new_string('parent_version')),
			var_theme.array_get(rt.new_string('parent_version_latest')),
			rt.new_string('<'),
		]))
		{
			print(' &ndash; <strong style="color:red;">' +
				(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s is available'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [var_theme.array_get(rt.new_string('parent_version_latest'))])])).str() +
				'</strong>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Parent theme author URL'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('The parent theme developers URL.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			var_theme.array_get(rt.new_string('parent_author_url')),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if var_theme.array_isset(rt.new_string('is_block_theme')) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Theme type'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wc_help_tip', [
			rt.call_function('esc_html__', [
				rt.new_string('Displays whether the current active theme is a block theme or a classic theme.'),
				rt.new_string('woocommerce'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(var_theme.array_get(rt.new_string('is_block_theme'))) {
			rt.call_function('esc_html_e', [rt.new_string('Block theme'),
				rt.new_string('woocommerce')])
		} else {
			rt.call_function('esc_html_e', [rt.new_string('Classic theme'),
				rt.new_string('woocommerce')])
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('WooCommerce support'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('Displays whether or not the current active theme declares WooCommerce support.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(!(rt.is_true(var_theme.array_get(rt.new_string('has_woocommerce_support')))))) {
		print('<mark class="error"><span class="dashicons dashicons-warning"></span> ' +
			(rt.call_function('esc_html__', [rt.new_string('Not declared'), rt.new_string('woocommerce')])).str() +
			'</mark>')
	} else {
		print('<mark class="yes"><span class="dashicons dashicons-yes"></span></mark>')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Templates'),
		rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('This section shows any files that are overriding the default WooCommerce template pages.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_theme.array_get(rt.new_string('has_woocommerce_file'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Archive template'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Your theme has a woocommerce.php file, you will not be able to override the woocommerce/archive-product.php custom template since woocommerce.php has priority over archive-product.php. This is intended to prevent display issues.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_theme.array_get(rt.new_string('overrides')))) {
		// unsupported statement: Stmt_InlineHTML
		mut iter_10 := var_theme.array_get(rt.new_string('overrides')).iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_override := item_10.val
			mut var_i := item_10.key
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.identical(rt.new_int(0), var_i)) {
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('esc_html_e', [rt.new_string('Overrides'),
					rt.new_string('woocommerce')])
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			print('<td>')
			print('<code>' +
				(rt.call_function('esc_html', [var_override.array_get(rt.new_string('file'))])).str() +
				'</code>')
			if rt.is_true(var_override.array_get(rt.new_string('core_version')))
				&& rt.is_true(rt.identical(rt.new_string(''), var_override.array_get(rt.new_string('version')))) {
				print(' <br><mark class="error"><span class="dashicons dashicons-warning"></span> ')
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Version header is missing. The core version is %s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<strong>' +
						(rt.call_function('esc_html', [var_override.array_get(rt.new_string('core_version'))])).str() +
						'</strong>'),
				])
				print('</mark>')
			} else if rt.is_true(var_override.array_get(rt.new_string('core_version')))
				&& rt.is_true(rt.call_function('version_compare', [var_override.array_get(rt.new_string('version')), var_override.array_get(rt.new_string('core_version')), rt.new_string('<')])) {
				print(' <br><mark class="error"><span class="dashicons dashicons-warning"></span> ')
				rt.call_function('printf', [
					rt.call_function('esc_html__', [
						rt.new_string('Version %1$s is out of date. The core version is %2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<strong>' +
						(rt.call_function('esc_html', [var_override.array_get(rt.new_string('version'))])).str() +
						'</strong>'),
					rt.new_string('<strong>' +
						(rt.call_function('esc_html', [var_override.array_get(rt.new_string('core_version'))])).str() +
						'</strong>'),
				])
				print('</mark>')
			}
			print('</td>')
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Overrides'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_bool(true),
		var_theme.array_get(rt.new_string('has_outdated_templates'))))
	{
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Outdated templates'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Learn how to update'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('admin_url', [
				rt.new_string('admin.php?page=wc-status&tab=tools'),
			]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Clear system status theme info cache'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_system_status_report'),
		var_report.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Status report information'),
		rt.new_string('woocommerce')])
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('esc_html__', [
			rt.new_string('This section shows information about this status report.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Generated at'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('current_time', [rt.new_string('Y-m-d H:i:s P')]),
	]))
	// unsupported statement: Stmt_InlineHTML
}
