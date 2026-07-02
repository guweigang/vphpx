import rt

struct Class_WP_Site_Health {
	rt.PhpObjectBase
pub mut:
	is_acceptable_mysql_version  rt.PhpVal = rt.new_null()
	is_recommended_mysql_version rt.PhpVal = rt.new_null()
	is_mariadb                   bool
	mysql_server_version         rt.PhpVal = rt.new_string('')
	mysql_required_version       rt.PhpVal = rt.new_string('5.5')
	mysql_recommended_version    rt.PhpVal = rt.new_string('8.0')
	mariadb_recommended_version  rt.PhpVal = rt.new_string('10.6')
	php_memory_limit             rt.PhpVal = rt.new_null()
	schedules                    rt.PhpVal = rt.new_null()
	crons                        rt.PhpVal = rt.new_null()
	last_missed_cron             rt.PhpVal = rt.new_null()
	last_late_cron               rt.PhpVal = rt.new_null()
	timeout_missed_cron          rt.PhpVal = rt.new_null()
	timeout_late_cron            rt.PhpVal = rt.new_null()
}

fn init_static_wp_site_health() {
	rt.init_static_prop('WP_Site_Health', 'instance', rt.new_null())
}

fn (mut this Class_WP_Site_Health) construct() {
	this.maybe_create_scheduled_event()
	this.php_memory_limit = rt.call_function('ini_get', [rt.new_string('memory_limit')])
	this.timeout_late_cron = rt.new_int(0)
	this.timeout_missed_cron = rt.mul(-5, rt.get_constant('MINUTE_IN_SECONDS'))
	if rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')]))
		&& rt.is_true(rt.get_constant('DISABLE_WP_CRON')) {
		this.timeout_late_cron = rt.mul(-15, rt.get_constant('MINUTE_IN_SECONDS'))
		this.timeout_missed_cron = rt.mul(-1, rt.get_constant('HOUR_IN_SECONDS'))
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'admin_body_class' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_scripts' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_site_health_scheduled_check'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'wp_cron_scheduled_check' },
		])])
	rt.call_function('add_action', [rt.new_string('site_health_tab_content'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'show_site_health_tab' },
		])])
}

fn (mut this Class_WP_Site_Health) show_site_health_tab(var_tab rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('debug'), var_tab)) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/site-health-info.php', '4')
	}
}

fn Class_WP_Site_Health.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('WP_Site_Health', 'instance'))) {
		rt.set_static_prop('WP_Site_Health', 'instance', rt.new_object('WP_Site_Health',
			[]string{}, create_wp_site_health()))
	}
	return rt.get_static_prop('WP_Site_Health', 'instance')
}

fn (mut this Class_WP_Site_Health) enqueue_scripts() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('site-health'), rt.get_property(var_screen, 'id')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('dashboard'), rt.get_property(var_screen, 'id'))))) {
		return
	}
	mut var_health_check_js_variables := {
		'screen':      rt.get_property(var_screen, 'id')
		'nonce':       {
			'site_status':        rt.call_function('wp_create_nonce', [
				rt.new_string('health-check-site-status'),
			])
			'site_status_result': rt.call_function('wp_create_nonce', [
				rt.new_string('health-check-site-status-result'),
			])
		}
		'site_status': {
			'direct': map[string]rt.PhpVal{}
			'async':  map[string]rt.PhpVal{}
			'issues': {
				'good':        rt.new_int(0)
				'recommended': rt.new_int(0)
				'critical':    rt.new_int(0)
			}
		}
	}
	mut var_issue_counts := rt.call_function('get_transient', [
		rt.new_string('health-check-site-status-result'),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_issue_counts)))) {
		var_issue_counts = rt.call_function('json_decode', [var_issue_counts.clone()])
		var_health_check_js_variables.array_get_mut('site_status').array_set('issues',
			var_issue_counts.clone())
	}
	if rt.is_true(rt.identical(rt.new_string('site-health'), rt.get_property(var_screen, 'id')))
		&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('tab')))
		|| !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('tab'))) {
		mut var_tests := Class_WP_Site_Health.get_tests()
		if rt.is_true(this.is_development_environment()) {
			var_tests.array_get(rt.new_string('async')).array_unset(rt.new_string('https_status'))
		}
		mut iter_1 := var_tests.array_get(rt.new_string('direct')).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_test := item_1.val
			if rt.is_true(rt.new_bool(var_test.array_get(rt.new_string('test')).is_string())) {
				mut var_test_function := rt.call_function('sprintf', [
					rt.new_string('get_test_%s'),
					var_test.array_get(rt.new_string('test')),
				])
				if rt.is_true(rt.call_function('method_exists', [rt.new_object('WP_Site_Health', []string{}, &this), var_test_function.clone()]))
					&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
					key: none
					val: rt.new_object('WP_Site_Health', []string{}, &this)
				}, rt.ArrayItem{ key: none, val: var_test_function }])]) {
					var_health_check_js_variables.array_get_mut('site_status').array_get_mut('direct').array_push(this.perform_test(rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{},
							&this) },
						rt.ArrayItem{ key: none, val: var_test_function },
					])))
					continue
				}
			}
			if rt.is_true(rt.call_function('is_callable', [
				var_test.array_get(rt.new_string('test')),
			]))
			{
				var_health_check_js_variables.array_get_mut('site_status').array_get_mut('direct').array_push(this.perform_test(var_test.array_get(rt.new_string('test'))))
			}
		}
		mut iter_2 := var_tests.array_get(rt.new_string('async')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_test := item_2.val
			if rt.is_true(rt.new_bool(var_test.array_get(rt.new_string('test')).is_string())) {
				var_health_check_js_variables.array_get_mut('site_status').array_get_mut('async').array_push(rt.create_array([
					rt.ArrayItem{ key: 'test', val: var_test.array_get(rt.new_string('test')) },
					rt.ArrayItem{
						key: 'has_rest'
						val: if !(var_test.array_get(rt.new_string('has_rest'))).is_null() {
							var_test.array_get(rt.new_string('has_rest'))
						} else {
							rt.new_bool(false)
						}
					},
					rt.ArrayItem{ key: 'completed', val: false },
					rt.ArrayItem{
						key: 'headers'
						val: if !(var_test.array_get(rt.new_string('headers'))).is_null() {
							var_test.array_get(rt.new_string('headers'))
						} else {
							map[string]rt.PhpVal{}
						}
					},
				]))
			}
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('site-health'),
		rt.new_string('SiteHealth'), rt.create_array_from_native_map(var_health_check_js_variables)])
}

fn (mut this Class_WP_Site_Health) perform_test(var_callback rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('site_status_test_result'),
		rt.call_function('call_user_func', [var_callback.clone()])])
}

fn (mut this Class_WP_Site_Health) prepare_sql_data() {
	mut var_wpdb := rt.new_null()
	mut var_mysql_server_type := rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
	this.mysql_server_version = rt.call_method(var_wpdb, 'get_var', [
		rt.new_string('SELECT VERSION()'),
	])
	if rt.is_true(rt.call_function('stristr', [var_mysql_server_type.clone(),
		rt.new_string('mariadb')]))
	{
		this.is_mariadb = true
		this.mysql_recommended_version = this.mariadb_recommended_version
	}
	this.is_acceptable_mysql_version = rt.call_function('version_compare', [
		this.mysql_required_version,
		this.mysql_server_version,
		rt.new_string('<='),
	])
	this.is_recommended_mysql_version = rt.call_function('version_compare', [
		this.mysql_recommended_version,
		this.mysql_server_version,
		rt.new_string('<='),
	])
}

fn (mut this Class_WP_Site_Health) check_wp_version_check_exists() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])))))
		|| !(rt.get_superglobal('_GET').array_isset(rt.new_string('health-check-test-wp_version_check'))) {
		return
	}
	print(if rt.is_true(rt.call_function('has_filter', [
		rt.new_string('wp_version_check'),
		rt.new_string('wp_version_check'),
	]))
	{ 'yes' } else { 'no' })
	exit(0)
}

fn (mut this Class_WP_Site_Health) get_test_wordpress_version() rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'label', val: '' },
		rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'wordpress_version' }])
	mut var_core_current_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_core_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
	if !(var_core_updates.clone().is_array()) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('WordPress version %s')]),
			var_core_current_version.clone(),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Unable to check if any new versions of WordPress are available.'),
			]),
		]))
		var_result.array_set('actions', rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string('update-core.php?force-check=1'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Check for updates manually'),
			]),
		]))
	} else {
		mut iter_3 := var_core_updates.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_update := item_3.val
			mut var_core := item_3.key
			if rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_update,
				'response')))
			{
				mut var_current_version := rt.call_function('explode', [
					rt.new_string('.'),
					var_core_current_version.clone(),
				])
				mut var_new_version := rt.call_function('explode', [
					rt.new_string('.'), rt.get_property(var_update, 'version')])
				mut var_current_major := rt.new_string(
					(var_current_version.array_get(rt.new_int(0))).str() + '.' +
					(var_current_version.array_get(rt.new_int(1))).str())
				mut var_new_major := rt.new_string(
					(var_new_version.array_get(rt.new_int(0))).str() + '.' +
					(var_new_version.array_get(rt.new_int(1))).str())
				var_result.array_set('label', rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('WordPress update available (%s)'),
					]),
					rt.get_property(var_update, 'version'),
				]))
				var_result.array_set('actions', rt.call_function('sprintf', [
					rt.new_string('<a href="%s">%s</a>'),
					rt.call_function('esc_url', [
						rt.call_function('admin_url', [rt.new_string('update-core.php')]),
					]),
					rt.call_function('__', [
						rt.new_string('Install the latest version of WordPress'),
					]),
				]))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_current_major, var_new_major)))) {
					var_result.array_set('status', 'recommended')
					var_result.array_set('description', rt.call_function('sprintf', [
						rt.new_string('<p>%s</p>'),
						rt.call_function('__', [
							rt.new_string('A new version of WordPress is available.'),
						]),
					]))
				} else {
					var_result.array_set('status', 'critical')
					var_result.array_get_mut('badge').array_set('label', rt.call_function('__', [
						rt.new_string('Security'),
					]))
					var_result.array_set('description', rt.call_function('sprintf', [
						rt.new_string('<p>%s</p>'),
						rt.call_function('__', [
							rt.new_string('A new minor update is available for your site. Because minor updates often address security, it&#8217;s important to install them.'),
						]),
					]))
				}
			} else {
				var_result.array_set('status', 'good')
				var_result.array_set('label', rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Your version of WordPress (%s) is up to date'),
					]),
					var_core_current_version.clone(),
				]))
				var_result.array_set('description', rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('__', [
						rt.new_string('You are currently running the latest version of WordPress available, keep it up!'),
					]),
				]))
			}
		}
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_plugin_version() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Your plugins are all up to date'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Plugins extend your site&#8217;s functionality with things like contact forms, ecommerce and much more. That means they have deep access to your site, so it&#8217;s vital to keep them up to date.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('plugins.php')]),
			]),
			rt.call_function('__', [
				rt.new_string('Manage your plugins'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'plugin_version' },
	])
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_plugin_updates := rt.call_function('get_plugin_updates', []rt.PhpVal{})
	mut var_plugins_active := rt.new_int(0)
	mut var_plugins_total := rt.new_int(0)
	mut var_plugins_need_update := rt.new_int(0)
	mut iter_4 := var_plugins.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin := item_4.val
		mut var_plugin_path := item_4.key
		rt.pre_inc(var_plugins_total)
		if rt.is_true(rt.call_function('is_plugin_active', [var_plugin_path.clone()])) {
			rt.pre_inc(var_plugins_active)
		}
		if rt.is_true(rt.new_bool(var_plugin_updates.clone().array_isset(var_plugin_path.clone()))) {
			rt.pre_inc(var_plugins_need_update)
		}
	}
	if rt.is_true(rt.greater(var_plugins_need_update, rt.new_int(0))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('You have plugins waiting to be updated'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('Your site has %d plugin waiting to be updated.'),
					rt.new_string('Your site has %d plugins waiting to be updated.'),
					var_plugins_need_update.clone(),
				]),
				var_plugins_need_update.clone(),
			]),
		]))
		var_result.array_get(rt.new_string('actions')) = rt.concat(var_result.array_get(rt.new_string('actions')), rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('network_admin_url', [
					rt.new_string('plugins.php?plugin_status=upgrade'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Update your plugins'),
			]),
		]))
	} else {
		if rt.is_true(rt.identical(rt.new_int(1), var_plugins_active)) {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('Your site has 1 active plugin, and it is up to date.'),
				]),
			]))
		} else if rt.is_true(rt.greater(var_plugins_active, rt.new_int(0))) {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('Your site has %d active plugin, and it is up to date.'),
						rt.new_string('Your site has %d active plugins, and they are all up to date.'),
						var_plugins_active.clone(),
					]),
					var_plugins_active.clone(),
				]),
			]))
		} else {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('Your site does not have any active plugins.'),
				]),
			]))
		}
	}
	if rt.is_true(rt.greater(var_plugins_total, var_plugins_active))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		mut var_unused_plugins := rt.sub(var_plugins_total, var_plugins_active)
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('You should remove inactive plugins'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s %s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('Your site has %d inactive plugin.'),
					rt.new_string('Your site has %d inactive plugins.'),
					var_unused_plugins.clone(),
				]),
				var_unused_plugins.clone(),
			]),
			rt.call_function('__', [
				rt.new_string('Inactive plugins are tempting targets for attackers. If you are not going to use a plugin, you should consider removing it.'),
			]),
		]))
		var_result.array_get(rt.new_string('actions')) = rt.concat(var_result.array_get(rt.new_string('actions')), rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string('plugins.php?plugin_status=inactive'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Manage inactive plugins'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_theme_version() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Your themes are all up to date'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Themes add your site&#8217;s look and feel. It&#8217;s important to keep them up to date, to stay consistent with your brand and keep your site secure.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('themes.php')]),
			]),
			rt.call_function('__', [
				rt.new_string('Manage your themes'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'theme_version' },
	])
	mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
	mut var_themes_total := rt.new_int(0)
	mut var_themes_need_updates := rt.new_int(0)
	mut var_themes_inactive := rt.new_int(0)
	mut var_allowed_theme_count := rt.new_int(1)
	mut var_has_default_theme := rt.new_bool(false)
	mut var_has_unused_themes := rt.new_bool(false)
	mut var_show_unused_themes := rt.new_bool(true)
	mut var_using_default_theme := rt.new_bool(false)
	mut var_all_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	mut var_active_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_default_theme := rt.call_function('wp_get_theme', [
		rt.get_constant('WP_DEFAULT_THEME'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_default_theme, 'exists',
		[]rt.PhpVal{})))))
	{
		mut iife_temp_0 := Class_WP_Theme{}
		mut iife_result_0 := iife_temp_0.get_core_default_theme()
		var_default_theme = iife_result_0
	}
	if rt.is_true(var_default_theme) {
		var_has_default_theme = rt.new_bool(true)
		if rt.is_true(rt.identical(rt.call_method(var_active_theme, 'get_stylesheet', []rt.PhpVal{}), rt.call_method(var_default_theme, 'get_stylesheet', []rt.PhpVal{})))
			|| (rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{}))
			&& rt.is_true(rt.identical(rt.call_method(var_active_theme, 'get_template', []rt.PhpVal{}), rt.call_method(var_default_theme, 'get_template', []rt.PhpVal{})))) {
			var_using_default_theme = rt.new_bool(true)
		}
	}
	mut iter_5 := var_all_themes.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_theme := item_5.val
		mut var_theme_slug := item_5.key
		rt.pre_inc(var_themes_total)
		if rt.is_true(rt.new_bool(var_theme_updates.clone().array_isset(var_theme_slug.clone()))) {
			rt.pre_inc(var_themes_need_updates)
		}
	}
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		rt.pre_inc(var_allowed_theme_count)
	}
	if rt.is_true(var_has_default_theme)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_using_default_theme)))) {
		rt.pre_inc(var_allowed_theme_count)
	}
	if rt.is_true(rt.greater(var_themes_total, var_allowed_theme_count)) {
		var_has_unused_themes = rt.new_bool(true)
		var_themes_inactive = rt.sub(var_themes_total, var_allowed_theme_count)
	}
	if rt.is_true(rt.greater(var_themes_need_updates, rt.new_int(0))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('You have themes waiting to be updated'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('_n', [
					rt.new_string('Your site has %d theme waiting to be updated.'),
					rt.new_string('Your site has %d themes waiting to be updated.'),
					var_themes_need_updates.clone(),
				]),
				var_themes_need_updates.clone(),
			]),
		]))
	} else {
		if rt.is_true(rt.identical(rt.new_int(1), var_themes_total)) {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('Your site has 1 installed theme, and it is up to date.'),
				]),
			]))
		} else if rt.is_true(rt.greater(var_themes_total, rt.new_int(0))) {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('Your site has %d installed theme, and it is up to date.'),
						rt.new_string('Your site has %d installed themes, and they are all up to date.'),
						var_themes_total.clone(),
					]),
					var_themes_total.clone(),
				]),
			]))
		} else {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('Your site does not have any installed themes.'),
				]),
			]))
		}
	}
	if rt.is_true(var_has_unused_themes) && rt.is_true(var_show_unused_themes)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		if rt.is_true(rt.call_method(var_active_theme, 'parent', []rt.PhpVal{})) {
			var_result.array_set('status', 'recommended')
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('You should remove inactive themes'),
			]))
			if rt.is_true(var_using_default_theme) {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s %s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('_n', [
							rt.new_string('Your site has %d inactive theme.'),
							rt.new_string('Your site has %d inactive themes.'),
							var_themes_inactive.clone(),
						]),
						var_themes_inactive.clone(),
					]),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('To enhance your site&#8217;s security, you should consider removing any themes you are not using. You should keep your active theme, %1$s, and %2$s, its parent theme.'),
						]),
						rt.get_property(var_active_theme, 'name'),
						rt.get_property(rt.call_method(var_active_theme, 'parent', []rt.PhpVal{}),
							'name'),
					]),
				]))
			} else {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s %s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('_n', [
							rt.new_string('Your site has %d inactive theme.'),
							rt.new_string('Your site has %d inactive themes.'),
							var_themes_inactive.clone(),
						]),
						var_themes_inactive.clone(),
					]),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('To enhance your site&#8217;s security, you should consider removing any themes you are not using. You should keep %1$s, the default WordPress theme, %2$s, your active theme, and %3$s, its parent theme.'),
						]),
						if rt.is_true(var_default_theme) {
							rt.get_property(var_default_theme, 'name')
						} else {
							rt.get_constant('WP_DEFAULT_THEME')
						},
						rt.get_property(var_active_theme, 'name'),
						rt.get_property(rt.call_method(var_active_theme, 'parent', []rt.PhpVal{}),
							'name'),
					]),
				]))
			}
		} else {
			var_result.array_set('status', 'recommended')
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('You should remove inactive themes'),
			]))
			if rt.is_true(var_using_default_theme) {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s %s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('_n', [
							rt.new_string('Your site has %1$d inactive theme, other than %2$s, your active theme.'),
							rt.new_string('Your site has %1$d inactive themes, other than %2$s, your active theme.'),
							var_themes_inactive.clone(),
						]),
						var_themes_inactive.clone(),
						rt.get_property(var_active_theme, 'name'),
					]),
					rt.call_function('__', [
						rt.new_string('You should consider removing any unused themes to enhance your site&#8217;s security.'),
					]),
				]))
			} else {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s %s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('_n', [
							rt.new_string('Your site has %1$d inactive theme, other than %2$s, the default WordPress theme, and %3$s, your active theme.'),
							rt.new_string('Your site has %1$d inactive themes, other than %2$s, the default WordPress theme, and %3$s, your active theme.'),
							var_themes_inactive.clone(),
						]),
						var_themes_inactive.clone(),
						if rt.is_true(var_default_theme) {
							rt.get_property(var_default_theme, 'name')
						} else {
							rt.get_constant('WP_DEFAULT_THEME')
						},
						rt.get_property(var_active_theme, 'name'),
					]),
					rt.call_function('__', [
						rt.new_string('You should consider removing any unused themes to enhance your site&#8217;s security.'),
					]),
				]))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_default_theme)))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Have a default theme available'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Your site does not have any default theme. Default themes are used by WordPress automatically if anything is wrong with your chosen theme.'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_php_version() rt.PhpVal {
	mut var_response := rt.call_function('wp_check_php_version', []rt.PhpVal{})
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Your site is running PHP %s')]),
			rt.get_constant('PHP_VERSION'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance')]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('PHP is one of the programming languages used to build WordPress. Newer versions of PHP receive regular security updates and may increase your site&#8217;s performance.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('wp_get_update_php_url', []rt.PhpVal{}),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about updating PHP'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'php_version' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_response)))) {
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Unable to determine the status of the current PHP version (%s)'),
			]),
			rt.get_constant('PHP_VERSION'),
		]))
		var_result.array_set('status', 'recommended')
		var_result.array_set('description', '<p><em>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unable to access the WordPress.org API for <a href="%s">Serve Happy</a>.')]), rt.new_string('https://codex.wordpress.org/WordPress.org_API#Serve_Happy')])).str() +
			'</em></p>' + (var_result.array_get(rt.new_string('description'))).str())
		return var_result.clone()
	}
	var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.new_string(
		'<p>' +
		(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The minimum recommended version of PHP is %s.')]), var_response.array_get(rt.new_string('recommended_version'))])).str() +
		'</p>'))
	if rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'),
		var_response.array_get(rt.new_string('recommended_version')),
		rt.new_string('>=')]))
	{
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running a recommended version of PHP (%s)'),
			]),
			rt.get_constant('PHP_VERSION'),
		]))
		var_result.array_set('status', 'good')
		return var_result.clone()
	}
	if rt.is_true(var_response.array_get(rt.new_string('is_supported'))) {
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an older version of PHP (%s)'),
			]),
			rt.get_constant('PHP_VERSION'),
		]))
		var_result.array_set('status', 'recommended')
		return var_result.clone()
	}
	if rt.is_true(var_response.array_get(rt.new_string('is_secure')))
		&& rt.is_true(var_response.array_get(rt.new_string('is_lower_than_future_minimum'))) {
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an outdated version of PHP (%s), which soon will not be supported by WordPress.'),
			]),
			rt.get_constant('PHP_VERSION'),
		]))
		var_result.array_set('status', 'critical')
		var_result.array_get_mut('badge').array_set('label', rt.call_function('__', [
			rt.new_string('Requirements'),
		]))
		return var_result.clone()
	}
	if rt.is_true(var_response.array_get(rt.new_string('is_secure'))) {
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an older version of PHP (%s), which should be updated'),
			]),
			rt.get_constant('PHP_VERSION'),
		]))
		var_result.array_set('status', 'recommended')
		return var_result.clone()
	}
	if rt.is_true(var_response.array_get(rt.new_string('is_lower_than_future_minimum'))) {
		mut var_message := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an outdated version of PHP (%s), which does not receive security updates and soon will not be supported by WordPress.'),
			]),
			rt.get_constant('PHP_VERSION'),
		])
	} else {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Your site is running on an outdated version of PHP (%s), which does not receive security updates. It should be updated.'),
			]),
			rt.get_constant('PHP_VERSION'),
		])
	}
	var_result.array_set('label', var_message.clone())
	var_result.array_set('status', 'critical')
	var_result.array_get_mut('badge').array_set('label', rt.call_function('__', [
		rt.new_string('Security'),
	]))
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) test_php_extension_availability(var_extension_name rt.PhpVal, var_function_name rt.PhpVal, var_constant_name rt.PhpVal, var_class_name rt.PhpVal) bool {
	mut var_extension_name_mutated := var_extension_name
	mut var_function_name_mutated := var_function_name
	mut var_constant_name_mutated := var_constant_name
	mut var_class_name_mutated := var_class_name
	if rt.is_true(rt.new_bool(!(rt.is_true(var_extension_name_mutated))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_function_name_mutated))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_constant_name_mutated))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_class_name_mutated)))) {
		return false
	}
	if rt.is_true(var_extension_name_mutated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [var_extension_name_mutated.clone()]))))) {
		return false
	}
	if rt.is_true(var_function_name_mutated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [var_function_name_mutated.clone()]))))) {
		return false
	}
	if rt.is_true(var_constant_name_mutated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [var_constant_name_mutated.clone()]))))) {
		return false
	}
	if rt.is_true(var_class_name_mutated)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [var_class_name_mutated.clone()]))))) {
		return false
	}
	return true
}

fn (mut this Class_WP_Site_Health) get_test_php_extensions() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Required and recommended modules are installed'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p><p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('PHP modules perform most of the tasks on the server that make your site run. Any changes to these must be made by your server administrator.'),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The WordPress Hosting Team maintains a list of those modules, both recommended and required, in <a href="%1$s" %2$s>the team handbook%3$s</a>.'),
				]),
				rt.call_function('esc_url', [
					rt.call_function('__', [
						rt.new_string('https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions'),
					]),
				]),
				rt.new_string('target="_blank"'),
				rt.call_function('sprintf', [
					rt.new_string('<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span>'),
					rt.call_function('__', [
						rt.new_string('(opens in a new tab)'),
					]),
				]),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'php_extensions' },
	])
	mut var_modules := rt.create_array([
		rt.ArrayItem{ key: 'curl', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'curl_version' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'dom', val: rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'DOMNode' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'exif', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'exif_read_data' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'fileinfo', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'finfo_file' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'hash', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'hash' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'imagick', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'imagick' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'json', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'json_last_error' },
			rt.ArrayItem{ key: 'required', val: true },
		]) },
		rt.ArrayItem{ key: 'mbstring', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'mb_check_encoding' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'mysqli', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'mysqli_connect' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'libsodium', val: rt.create_array([
			rt.ArrayItem{ key: 'constant', val: 'SODIUM_LIBRARY_VERSION' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'php_bundled_version', val: '7.2.0' },
		]) },
		rt.ArrayItem{ key: 'openssl', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'openssl_encrypt' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'pcre', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'preg_match' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'mod_xml', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'libxml' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'zip', val: rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'ZipArchive' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'filter', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'filter_list' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'gd', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'gd' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'fallback_for', val: 'imagick' },
		]) },
		rt.ArrayItem{ key: 'iconv', val: rt.create_array([
			rt.ArrayItem{ key: 'function', val: 'iconv' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'intl', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'intl' },
			rt.ArrayItem{ key: 'required', val: false },
		]) },
		rt.ArrayItem{ key: 'mcrypt', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'mcrypt' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'fallback_for', val: 'libsodium' },
		]) },
		rt.ArrayItem{ key: 'simplexml', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'simplexml' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'fallback_for', val: 'mod_xml' },
		]) },
		rt.ArrayItem{ key: 'xmlreader', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'xmlreader' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'fallback_for', val: 'mod_xml' },
		]) },
		rt.ArrayItem{ key: 'zlib', val: rt.create_array([
			rt.ArrayItem{ key: 'extension', val: 'zlib' },
			rt.ArrayItem{ key: 'required', val: false },
			rt.ArrayItem{ key: 'fallback_for', val: 'zip' },
		]) },
	])
	var_modules = rt.call_function('apply_filters', [
		rt.new_string('site_status_test_php_modules'),
		var_modules.clone(),
	])
	mut var_failures := map[string]rt.PhpVal{}
	mut iter_6 := var_modules.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_module := item_6.val
		mut var_library := item_6.key
		mut var_extension_name := if !(var_module.array_get(rt.new_string('extension'))).is_null() {
			var_module.array_get(rt.new_string('extension'))
		} else {
			rt.new_null()
		}
		mut var_function_name := if !(var_module.array_get(rt.new_string('function'))).is_null() {
			var_module.array_get(rt.new_string('function'))
		} else {
			rt.new_null()
		}
		mut var_constant_name := if !(var_module.array_get(rt.new_string('constant'))).is_null() {
			var_module.array_get(rt.new_string('constant'))
		} else {
			rt.new_null()
		}
		mut var_class_name := if !(var_module.array_get(rt.new_string('class'))).is_null() {
			var_module.array_get(rt.new_string('class'))
		} else {
			rt.new_null()
		}
		if var_module.array_isset(rt.new_string('fallback_for')) {
			if var_failures.array_isset(var_module.array_get(rt.new_string('fallback_for'))) {
				var_module.array_set('required', true)
			} else {
				continue
			}
		}
		if !(this.test_php_extension_availability(var_extension_name.clone(), var_function_name.clone(), var_constant_name.clone(), var_class_name.clone()))
			&& !(var_module.array_isset(rt.new_string('php_bundled_version')))
			|| rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), var_module.array_get(rt.new_string('php_bundled_version')), rt.new_string('<')])) {
			if rt.is_true(var_module.array_get(rt.new_string('required'))) {
				var_result.array_set('status', 'critical')
				mut var_class := rt.new_string('error')
				mut var_screen_reader := rt.call_function('__', [
					rt.new_string('Error')])
				mut var_message := rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The required module, %s, is not installed, or has been disabled.'),
					]),
					var_library.clone(),
				])
			} else {
				var_class = rt.new_string('warning')
				var_screen_reader = rt.call_function('__', [rt.new_string('Warning')])
				var_message = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The optional module, %s, is not installed, or has been disabled.'),
					]),
					var_library.clone(),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_module.array_get(rt.new_string('required'))))))
				&& rt.is_true(rt.identical(rt.new_string('good'), var_result.array_get(rt.new_string('status')))) {
				var_result.array_set('status', 'recommended')
			}
			var_failures.array_set(var_library,
				"<span class='dashicons ${var_class.to_string()}' aria-hidden='true'></span><span class='screen-reader-text'>${var_screen_reader.to_string()}</span> ${var_message.to_string()}")
		}
	}
	if !(!rt.is_true(var_failures)) {
		mut var_output := rt.new_string('<ul>')
		mut iter_7 := var_failures.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_failure := item_7.val
			var_output = rt.concat(var_output, rt.call_function('sprintf', [
				rt.new_string('<li>%s</li>'),
				var_failure.clone(),
			]))
		}
		var_output = rt.concat(var_output, rt.new_string('</ul>'))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('good'),
		var_result.array_get(rt.new_string('status'))))))
	{
		if rt.is_true(rt.identical(rt.new_string('recommended'),
			var_result.array_get(rt.new_string('status'))))
		{
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('One or more recommended modules are missing'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_string('critical'),
			var_result.array_get(rt.new_string('status'))))
		{
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('One or more required modules are missing'),
			]))
		}
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')),
			var_output)
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_php_default_timezone() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('PHP default timezone is valid'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('PHP default timezone was configured by WordPress on loading. This is necessary for correct calculations of dates and times.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'php_default_timezone' },
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('UTC'), rt.call_function('date_default_timezone_get',
		[]rt.PhpVal{})))))
	{
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('PHP default timezone is invalid'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PHP default timezone was changed after WordPress loading by a %s function call. This interferes with correct calculations of dates and times.'),
				]),
				rt.new_string('<code>date_default_timezone_set()</code>'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_php_sessions() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('No PHP sessions detected'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PHP sessions created by a %1$s function call may interfere with REST API and loopback requests. An active session should be closed by %2$s before making any HTTP requests.'),
				]),
				rt.new_string('<code>session_start()</code>'),
				rt.new_string('<code>session_write_close()</code>'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'php_sessions' },
	])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('session_status')]))
		&& rt.is_true(rt.identical(rt.get_constant('PHP_SESSION_ACTIVE'), rt.call_function('session_status', []rt.PhpVal{}))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('An active PHP session was detected'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('A PHP session was created by a %1$s function call. This interferes with REST API and loopback requests. The session should be closed by %2$s before making any HTTP requests.'),
				]),
				rt.new_string('<code>session_start()</code>'),
				rt.new_string('<code>session_write_close()</code>'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_sql_server() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.mysql_server_version)))) {
		this.prepare_sql_data()
	}
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('SQL server is up to date'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('The SQL server is a required piece of software for the database WordPress uses to store all your site&#8217;s content and settings.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/about/requirements/'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about what WordPress requires to run.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'sql_server' },
	])
	mut var_db_dropin := rt.call_function('file_exists', [
		rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/db.php'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_recommended_mysql_version)))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Outdated SQL server'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('For optimal performance and security reasons, you should consider running %1$s version %2$s or higher. Contact your web hosting company to correct this.'),
				]),
				rt.new_string((if this.is_mariadb { 'MariaDB' } else { 'MySQL' }).str()),
				this.mysql_recommended_version,
			]),
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_acceptable_mysql_version)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Severely outdated SQL server'),
		]))
		var_result.array_get_mut('badge').array_set('label', rt.call_function('__', [
			rt.new_string('Security'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('WordPress requires %1$s version %2$s or higher. Contact your web hosting company to correct this.'),
				]),
				rt.new_string((if this.is_mariadb { 'MariaDB' } else { 'MySQL' }).str()),
				this.mysql_required_version,
			]),
		]))
	}
	if rt.is_true(var_db_dropin) {
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('wp_kses', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('You are using a %1$s drop-in which might mean that a %2$s database is not being used.'),
					]),
					rt.new_string('<code>wp-content/db.php</code>'),
					rt.new_string((if this.is_mariadb { 'MariaDB' } else { 'MySQL' }).str()),
				]),
				rt.create_array([
					rt.ArrayItem{ key: 'code', val: true },
				]),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_dotorg_communication() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Can communicate with WordPress.org'),
		]) },
		rt.ArrayItem{ key: 'status', val: '' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Communicating with the WordPress servers is used to check for new versions, and to both install and update WordPress core, themes or plugins.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'dotorg_communication' },
	])
	mut var_wp_dotorg := rt.call_function('wp_remote_get', [
		rt.new_string('https://api.wordpress.org'),
		rt.create_array([rt.ArrayItem{ key: 'timeout', val: 10 }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
		var_wp_dotorg.clone()])))))
	{
		var_result.array_set('status', 'good')
	} else {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Could not reach WordPress.org'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.new_string('<span class="error"><span class="screen-reader-text">%s</span></span> %s'),
				rt.call_function('__', [
					rt.new_string('Error'),
				]),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Your site is unable to reach WordPress.org at %1$s, and returned the error: %2$s'),
					]),
					rt.call_function('gethostbyname', [
						rt.new_string('api.wordpress.org'),
					]),
					rt.call_method(var_wp_dotorg, 'get_error_message', []rt.PhpVal{}),
				]),
			]),
		]))
		var_result.array_set('actions', rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forums/'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Get help resolving this issue.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_is_in_debug_mode() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Your site is not set to output debug information'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Debug mode is often enabled to gather more details about an error or site failure, but may contain sensitive information which should not be available on a publicly available website.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('__', [
					rt.new_string('https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about debugging in WordPress.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'is_in_debug_mode' },
	])
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG')) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_LOG')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG_LOG')) {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Your site is set to log errors to a potentially public file'),
			]))
			var_result.array_set('status', if rt.is_true(rt.call_function('str_starts_with', [
				rt.call_function('ini_get', [rt.new_string('error_log')]),
				rt.get_constant('ABSPATH'),
			]))
			{ 'critical' } else { 'recommended' })
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The value, %s, has been added to this website&#8217;s configuration file. This means any errors on the site will be written to a file which is potentially available to all users.'),
					]),
					rt.new_string('<code>WP_DEBUG_LOG</code>'),
				]),
			]))
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_DISPLAY')]))
			&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY')) {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Your site is set to display errors to site visitors'),
			]))
			var_result.array_set('status', 'critical')
			if rt.is_true(this.is_development_environment()) {
				var_result.array_set('status', 'recommended')
			}
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The value, %1$s, has either been enabled by %2$s or added to your configuration file. This will make errors display on the front end of your site.'),
					]),
					rt.new_string('<code>WP_DEBUG_DISPLAY</code>'),
					rt.new_string('<code>WP_DEBUG</code>'),
				]),
			]))
		}
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_https_status() rt.PhpVal {
	mut var_errors := rt.call_function('wp_get_https_detection_errors', []rt.PhpVal{})
	mut var_default_update_url := rt.call_function('wp_get_default_update_https_url', []rt.PhpVal{})
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Your website is using an active HTTPS connection'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('An HTTPS connection is a more secure way of browsing the web. Many services now have HTTPS as a requirement. HTTPS allows you to take advantage of new features that can increase site speed, improve search rankings, and gain the trust of your visitors by helping to protect their online privacy.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				var_default_update_url.clone(),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about why you should use HTTPS'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'https_status' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_using_https', []rt.PhpVal{}))))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Your website does not use HTTPS'),
		]))
		if rt.is_true(rt.call_function('wp_is_site_url_using_https', []rt.PhpVal{})) {
			if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
				var_result.array_set('description', rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('You are accessing this website using HTTPS, but your <a href="%s">Site Address</a> is not set up to use HTTPS by default.'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#home'),
						]),
					]),
				]))
			} else {
				var_result.array_set('description', rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Your <a href="%s">Site Address</a> is not set up to use HTTPS.'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#home'),
						]),
					]),
				]))
			}
		} else {
			if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
				var_result.array_set('description', rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('You are accessing this website using HTTPS, but your <a href="%1$s">WordPress Address</a> and <a href="%2$s">Site Address</a> are not set up to use HTTPS by default.'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#siteurl'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#home'),
						]),
					]),
				]))
			} else {
				var_result.array_set('description', rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Your <a href="%1$s">WordPress Address</a> and <a href="%2$s">Site Address</a> are not set up to use HTTPS.'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#siteurl'),
						]),
						rt.call_function('esc_url', [
							rt.new_string(
								(rt.call_function('admin_url', [rt.new_string('options-general.php')])).str() +
								'#home'),
						]),
					]),
				]))
			}
		}
		if rt.is_true(rt.call_function('wp_is_https_supported', []rt.PhpVal{})) {
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('__', [
					rt.new_string('HTTPS is already supported for your website.'),
				]),
			]))
			if rt.is_true(rt.call_function('defined', [rt.new_string('WP_HOME')]))
				|| rt.is_true(rt.call_function('defined', [rt.new_string('WP_SITEURL')])) {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('However, your WordPress Address is currently controlled by a PHP constant and therefore cannot be updated. You need to edit your %1$s and remove or update the definitions of %2$s and %3$s.'),
						]),
						rt.new_string('<code>wp-config.php</code>'),
						rt.new_string('<code>WP_HOME</code>'),
						rt.new_string('<code>WP_SITEURL</code>'),
					]),
				]))
			} else if rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('update_https'),
			]))
			{
				mut var_default_direct_update_url := rt.call_function('add_query_arg', [
					rt.new_string('action'),
					rt.new_string('update_https'),
					rt.call_function('wp_nonce_url', [
						rt.call_function('admin_url', [rt.new_string('site-health.php')]),
						rt.new_string('wp_update_https'),
					]),
				])
				mut var_direct_update_url := rt.call_function('wp_get_direct_update_https_url',
					[]rt.PhpVal{})
				if !(!rt.is_true(var_direct_update_url)) {
					var_result.array_set('actions', rt.call_function('sprintf', [
						rt.new_string('<p class="button-container"><a class="button button-primary" href="%1$s" target="_blank">%2$s<span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
						rt.call_function('esc_url', [var_direct_update_url.clone()]),
						rt.call_function('__', [rt.new_string('Update your site to use HTTPS')]),
						rt.call_function('__', [rt.new_string('(opens in a new tab)')]),
					]))
				} else {
					var_result.array_set('actions', rt.call_function('sprintf', [
						rt.new_string('<p class="button-container"><a class="button button-primary" href="%1$s">%2$s</a></p>'),
						rt.call_function('esc_url', [var_default_direct_update_url.clone()]),
						rt.call_function('__', [rt.new_string('Update your site to use HTTPS')]),
					]))
				}
			}
		} else {
			mut var_update_url := rt.call_function('wp_get_update_https_url', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_update_url,
				var_default_update_url))))
			{
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
					rt.call_function('esc_url', [var_update_url.clone()]),
					rt.call_function('__', [
						rt.new_string('Talk to your web host about supporting HTTPS for your website.'),
					]),
					rt.call_function('__', [
						rt.new_string('(opens in a new tab)'),
					]),
				]))
			} else {
				var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
					rt.new_string('<p>%s</p>'),
					rt.call_function('__', [
						rt.new_string('Talk to your web host about supporting HTTPS for your website.'),
					]),
				]))
			}
		}
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_ssl_support() rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'label', val: '' },
		rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Securely communicating between servers are needed for transactions such as fetching files, conducting sales on store sites, and much more.'),
			]),
		]) }, rt.ArrayItem{ key: 'actions', val: '' }, rt.ArrayItem{ key: 'test', val: 'ssl_support' }])
	mut var_supports_https := rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	])
	if rt.is_true(var_supports_https) {
		var_result.array_set('status', 'good')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Your site can communicate securely with other services'),
		]))
	} else {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Your site is unable to communicate securely with other services'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Talk to your web host about OpenSSL support for PHP.'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_scheduled_events() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Scheduled events are running'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Scheduled events are what periodically looks for updates to plugins, themes and WordPress itself. It is also what makes sure scheduled posts are published on time. It may also be used by various plugins to make sure that planned actions are executed.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'scheduled_events' },
	])
	this.wp_schedule_test_init()
	if rt.is_true(rt.call_function('is_wp_error', [rt.new_bool(this.has_missed_cron())])) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('It was not possible to check your scheduled events'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('While trying to test your site&#8217;s scheduled events, the following error was returned: %s'),
				]),
				rt.call_method(this.has_missed_cron(), 'get_error_message', []rt.PhpVal{}),
			]),
		]))
	} else if this.has_missed_cron() {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('A scheduled event has failed'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The scheduled event, %s, failed to run. Your site still works, but this may indicate that scheduling posts or automated updates may not work as intended.'),
				]),
				this.last_missed_cron,
			]),
		]))
	} else if this.has_late_cron() {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('A scheduled event is late'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The scheduled event, %s, is late to run. Your site still works, but this may indicate that scheduling posts or automated updates may not work as intended.'),
				]),
				this.last_late_cron,
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_background_updates() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Background updates are working'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Background updates ensure that WordPress can auto-update if a security update is released for the version you are currently using.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'background_updates' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Site_Health_Auto_Updates'),
	])))))
	{
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-site-health-auto-updates.php',
			'4')
	}
	mut var_automatic_updates := create_wp_site_health_auto_updates()
	mut var_tests := var_automatic_updates.run_tests()
	mut var_output := rt.new_string('<ul>')
	mut iter_8 := var_tests.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_test := item_8.val
		mut var_severity_string := rt.call_function('__', [rt.new_string('Passed')])
		if rt.is_true(rt.identical(rt.new_string('fail'), rt.get_property(var_test, 'severity'))) {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Background updates are not working as expected'),
			]))
			var_result.array_set('status', 'critical')
			var_severity_string = rt.call_function('__', [rt.new_string('Error')])
		}
		if rt.is_true(rt.identical(rt.new_string('warning'), rt.get_property(var_test, 'severity')))
			&& rt.is_true(rt.identical(rt.new_string('good'), var_result.array_get(rt.new_string('status')))) {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Background updates may not be working properly'),
			]))
			var_result.array_set('status', 'recommended')
			var_severity_string = rt.call_function('__', [rt.new_string('Warning')])
		}
		var_output = rt.concat(var_output, rt.call_function('sprintf', [
			rt.new_string('<li><span class="dashicons %s"><span class="screen-reader-text">%s</span></span> %s</li>'),
			rt.call_function('esc_attr', [rt.get_property(var_test, 'severity')]),
			var_severity_string.clone(),
			rt.get_property(var_test, 'description'),
		]))
	}
	var_output = rt.concat(var_output, rt.new_string('</ul>'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('good'),
		var_result.array_get(rt.new_string('status'))))))
	{
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')),
			var_output)
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_plugin_theme_auto_updates() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Plugin and theme auto-updates appear to be configured correctly'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Plugin and theme auto-updates ensure that the latest versions are always installed.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'plugin_theme_auto_updates' },
	])
	mut var_check_plugin_theme_updates := this.detect_plugin_theme_auto_update_issues()
	var_result.array_set('status', rt.get_property(var_check_plugin_theme_updates, 'status'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('good'),
		var_result.array_get(rt.new_string('status'))))))
	{
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Your site may have problems auto-updating plugins and themes'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.get_property(var_check_plugin_theme_updates, 'message'),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_available_updates_disk_space() rt.PhpVal {
	mut var_available_space := if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('disk_free_space'),
	]))
	{
		rt.call_function('disk_free_space', [rt.get_constant('WP_CONTENT_DIR')])
	} else {
		rt.new_bool(false)
	}
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Disk space available to safely perform updates'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('%s available disk space was detected, update routines can be performed safely.')])).str() +
				'</p>'),
			rt.call_function('size_format', [
				var_available_space.clone(),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'available_updates_disk_space' },
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_available_space)) {
		var_result.array_set('description', rt.call_function('__', [
			rt.new_string('Could not determine available disk space for updates.'),
		]))
		var_result.array_set('status', 'recommended')
	} else if rt.is_true(rt.less(var_available_space, rt.mul(rt.new_int(20),
		rt.get_constant('MB_IN_BYTES'))))
	{
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Available disk space is critically low, less than %s available. Proceed with caution, updates may fail.'),
			]),
			rt.call_function('size_format', [
				rt.mul(rt.new_int(20), rt.get_constant('MB_IN_BYTES')),
			]),
		]))
		var_result.array_set('status', 'critical')
	} else if rt.is_true(rt.less(var_available_space, rt.mul(rt.new_int(100),
		rt.get_constant('MB_IN_BYTES'))))
	{
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Available disk space is low, less than %s available.'),
			]),
			rt.call_function('size_format', [
				rt.mul(rt.new_int(100), rt.get_constant('MB_IN_BYTES')),
			]),
		]))
		var_result.array_set('status', 'recommended')
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_insecure_registration() rt.PhpVal {
	mut var_users_can_register := rt.call_function('get_option', [
		rt.new_string('users_can_register'),
	])
	mut var_default_role := rt.call_function('get_option', [
		rt.new_string('default_role'),
	])
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Open Registration with privileged default role'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: '<p>' +
			(rt.call_function('__', [rt.new_string('The combination of open registration setting and the default user role may lead to security issues.')])).str() +
			'</p>' },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'insecure_registration' },
	])
	if rt.is_true(var_users_can_register)
		&& rt.is_true(rt.call_function('in_array', [var_default_role.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'editor'
	}, rt.ArrayItem{ key: none, val: 'administrator' }]), rt.new_bool(true)])) {
		var_result.array_set('description', rt.call_function('__', [
			rt.new_string('Registration is open to anyone, and the default role is set to a privileged role.'),
		]))
		var_result.array_set('status', 'critical')
		var_result.array_set('actions', rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('options-general.php')]),
			]),
			rt.call_function('__', [
				rt.new_string('Change these settings'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_update_temp_backup_writable() rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Plugin and theme temporary backup directory is writable'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory used to improve the stability of plugin and theme updates is writable.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup</code>'),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'update_temp_backup_writable' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('WP_Filesystem'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_credentials := rt.call_function('request_filesystem_credentials', [
		rt.new_string(''),
	])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Could not access filesystem'),
		]))
		var_result.array_set('description', rt.call_function('__', [
			rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.'),
		]))
		return var_result.clone()
	}
	mut var_wp_content := rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_content)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Unable to locate WordPress content directory'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory cannot be located.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content</code>'),
		]))
		return var_result.clone()
	}
	mut var_upgrade_dir_exists := rt.call_method(var_wp_filesystem, 'is_dir', [
		rt.new_string('${var_wp_content.to_string()}/upgrade'),
	])
	mut var_upgrade_dir_is_writable := rt.call_method(var_wp_filesystem, 'is_writable', [
		rt.new_string('${var_wp_content.to_string()}/upgrade'),
	])
	mut var_backup_dir_exists := rt.call_method(var_wp_filesystem, 'is_dir', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup'),
	])
	mut var_backup_dir_is_writable := rt.call_method(var_wp_filesystem, 'is_writable', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup'),
	])
	mut var_plugins_dir_exists := rt.call_method(var_wp_filesystem, 'is_dir', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup/plugins'),
	])
	mut var_plugins_dir_is_writable := rt.call_method(var_wp_filesystem, 'is_writable', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup/plugins'),
	])
	mut var_themes_dir_exists := rt.call_method(var_wp_filesystem, 'is_dir', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup/themes'),
	])
	mut var_themes_dir_is_writable := rt.call_method(var_wp_filesystem, 'is_writable', [
		rt.new_string('${var_wp_content.to_string()}/upgrade-temp-backup/themes'),
	])
	if rt.is_true(var_plugins_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_plugins_dir_is_writable))))
		&& rt.is_true(var_themes_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_themes_dir_is_writable)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Plugin and theme temporary backup directories exist but are not writable'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %1$s and %2$s directories exist but are not writable. These directories are used to improve the stability of plugin updates. Please make sure the server has write permissions to these directories.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup/plugins</code>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup/themes</code>'),
		]))
		return var_result.clone()
	}
	if rt.is_true(var_plugins_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_plugins_dir_is_writable)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Plugin temporary backup directory exists but is not writable'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory exists but is not writable. This directory is used to improve the stability of plugin updates. Please make sure the server has write permissions to this directory.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup/plugins</code>'),
		]))
		return var_result.clone()
	}
	if rt.is_true(var_themes_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_themes_dir_is_writable)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Theme temporary backup directory exists but is not writable'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory exists but is not writable. This directory is used to improve the stability of theme updates. Please make sure the server has write permissions to this directory.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup/themes</code>'),
		]))
		return var_result.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugins_dir_exists))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_themes_dir_exists))))
		&& rt.is_true(var_backup_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_backup_dir_is_writable)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The temporary backup directory exists but is not writable'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory exists but is not writable. This directory is used to improve the stability of plugin and theme updates. Please make sure the server has write permissions to this directory.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade-temp-backup</code>'),
		]))
		return var_result.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_backup_dir_exists))))
		&& rt.is_true(var_upgrade_dir_exists)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_upgrade_dir_is_writable)))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The upgrade directory exists but is not writable'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %s directory exists but is not writable. This directory is used for plugin and theme updates. Please make sure the server has write permissions to this directory.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade</code>'),
		]))
		return var_result.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_upgrade_dir_exists))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'is_writable', [var_wp_content.clone()]))))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The upgrade directory cannot be created'),
		]))
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('__', [rt.new_string('The %1$s directory does not exist, and the server does not have write permissions in %2$s to create it. This directory is used for plugin and theme updates. Please make sure the server has write permissions in %2$s.')])).str() +
				'</p>'),
			rt.new_string('<code>wp-content/upgrade</code>'),
			rt.new_string('<code>wp-content</code>'),
		]))
		return var_result.clone()
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_loopback_requests() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Your site can perform loopback requests'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Loopback requests are used to run scheduled events, and are also used by the built-in editors for themes and plugins to verify code stability.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'loopback_requests' },
	])
	mut var_check_loopback := this.can_perform_loopback()
	var_result.array_set('status', rt.get_property(var_check_loopback, 'status'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('good'),
		var_result.array_get(rt.new_string('status'))))))
	{
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Your site could not complete a loopback request'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.get_property(var_check_loopback, 'message'),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_http_requests() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('HTTP requests seem to be working as expected'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('It is possible for site maintainers to block all, or some, communication to other sites and services. If set up incorrectly, this may prevent plugins and themes from working as intended.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'http_requests' },
	])
	mut var_blocked := rt.new_bool(false)
	mut var_hosts := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_HTTP_BLOCK_EXTERNAL')]))
		&& rt.is_true(rt.get_constant('WP_HTTP_BLOCK_EXTERNAL')) {
		var_blocked = rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_ACCESSIBLE_HOSTS')])) {
		var_hosts = rt.call_function('explode', [rt.new_string(','),
			rt.get_constant('WP_ACCESSIBLE_HOSTS')])
	}
	if rt.is_true(var_blocked) && 0 == var_hosts.clone().array_count() {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('HTTP requests are blocked'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('HTTP requests have been blocked by the %s constant, with no allowed hosts.'),
				]),
				rt.new_string('<code>WP_HTTP_BLOCK_EXTERNAL</code>'),
			]),
		]))
	}
	if rt.is_true(var_blocked) && 0 < var_hosts.clone().array_count() {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('HTTP requests are partially blocked'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('HTTP requests have been blocked by the %1$s constant, with some allowed hosts: %2$s.'),
				]),
				rt.new_string('<code>WP_HTTP_BLOCK_EXTERNAL</code>'),
				rt.call_function('implode', [
					rt.new_string(','),
					var_hosts.clone(),
				]),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_rest_availability() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('The REST API is available'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('The REST API is one way that WordPress and other applications communicate with the server. For example, the block editor screen relies on the REST API to display and save your posts and pages.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'rest_availability' },
	])
	mut var_cookies := rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').clone()])
	mut var_timeout := rt.new_int(10)
	mut var_headers := rt.create_array([
		rt.ArrayItem{ key: 'Cache-Control', val: 'no-cache' },
		rt.ArrayItem{ key: 'X-WP-Nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('wp_rest'),
		]) },
	])
	mut var_sslverify := rt.call_function('apply_filters', [
		rt.new_string('https_local_ssl_verify'),
		rt.new_bool(false),
	])
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		var_headers.array_set('Authorization', 'Basic ' +
			(rt.call_function('base64_encode', [rt.new_string((rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))])).str() +
			':' +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))])).str())])).str())
	}
	mut var_url := rt.call_function('rest_url', [rt.new_string('wp/v2/types/post')])
	var_url = rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'context', val: 'edit' }]),
		var_url.clone(),
	])
	mut var_r := rt.call_function('wp_remote_get', [var_url.clone(),
		rt.call_function('compact', [rt.new_string('cookies'),
			rt.new_string('headers'), rt.new_string('timeout'),
			rt.new_string('sslverify')])])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The REST API encountered an error'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p><p>%s<br>%s</p>'),
			rt.call_function('__', [
				rt.new_string('When testing the REST API, an error was encountered:'),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('REST API Endpoint: %s')]),
				var_url.clone(),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('REST API Response: (%1$s) %2$s')]),
				rt.call_method(var_r, 'get_error_code', []rt.PhpVal{}),
				rt.call_method(var_r, 'get_error_message', []rt.PhpVal{}),
			]),
		]))
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [
		var_r.clone(),
	])))))
	{
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The REST API encountered an unexpected result'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p><p>%s<br>%s</p>'),
			rt.call_function('__', [
				rt.new_string('When testing the REST API, an unexpected result was returned:'),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('REST API Endpoint: %s')]),
				var_url.clone(),
			]),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('REST API Response: (%1$s) %2$s')]),
				rt.call_function('wp_remote_retrieve_response_code', [
					var_r.clone()]),
				rt.call_function('wp_remote_retrieve_response_message', [
					var_r.clone()]),
			]),
		]))
	} else {
		mut var_json := rt.call_function('json_decode', [
			rt.call_function('wp_remote_retrieve_body', [var_r.clone()]),
			rt.new_bool(true),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_json))))
			&& !(var_json.array_isset(rt.new_string('capabilities'))) {
			var_result.array_set('status', 'recommended')
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('The REST API did not behave correctly'),
			]))
			var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The REST API did not process the %s query parameter correctly.'),
					]),
					rt.new_string('<code>context</code>'),
				]),
			]))
		}
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_file_uploads() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Files can be uploaded'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %1$s directive in %2$s determines if uploading files is allowed on your site.'),
				]),
				rt.new_string('<code>file_uploads</code>'),
				rt.new_string('<code>php.ini</code>'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'file_uploads' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('ini_get'),
	])))))
	{
		var_result.array_set('status', 'critical')
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The %s function has been disabled, some media settings are unavailable because of this.'),
			]),
			rt.new_string('<code>ini_get()</code>'),
		]))
		return var_result.clone()
	}
	if !rt.is_true(rt.call_function('ini_get', [rt.new_string('file_uploads')])) {
		var_result.array_set('status', 'critical')
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("%1$s is set to %2$s. You won't be able to upload files on your site."),
				]),
				rt.new_string('<code>file_uploads</code>'),
				rt.new_string('<code>0</code>'),
			]),
		]))
		return var_result.clone()
	}
	mut var_post_max_size := rt.call_function('ini_get', [rt.new_string('post_max_size')])
	mut var_upload_max_filesize := rt.call_function('ini_get', [
		rt.new_string('upload_max_filesize'),
	])
	if rt.is_true(rt.less(rt.call_function('wp_convert_hr_to_bytes', [
		var_post_max_size.clone()]), rt.call_function('wp_convert_hr_to_bytes', [
		var_upload_max_filesize.clone(),
	])))
	{
		var_result.array_set('label', rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('The "%1$s" value is smaller than "%2$s"'),
			]),
			rt.new_string('post_max_size'),
			rt.new_string('upload_max_filesize'),
		]))
		var_result.array_set('status', 'recommended')
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('wp_convert_hr_to_bytes', [
			var_post_max_size.clone(),
		])))
		{
			var_result.array_set('description', rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The setting for %1$s is currently configured as 0, this could cause some problems when trying to upload files through plugin or theme features that rely on various upload methods. It is recommended to configure this setting to a fixed value, ideally matching the value of %2$s, as some upload methods read the value 0 as either unlimited, or disabled.'),
					]),
					rt.new_string('<code>post_max_size</code>'),
					rt.new_string('<code>upload_max_filesize</code>'),
				]),
			]))
		} else {
			var_result.array_set('description', rt.call_function('sprintf', [
				rt.new_string('<p>%s</p>'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The setting for %1$s is smaller than %2$s, this could cause some problems when trying to upload files.'),
					]),
					rt.new_string('<code>post_max_size</code>'),
					rt.new_string('<code>upload_max_filesize</code>'),
				]),
			]))
		}
		return var_result.clone()
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_authorization_header() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('The Authorization header is working as expected'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Security'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('The Authorization header is used by third-party applications you have approved for this site. Without this header, those apps cannot connect to your site.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'authorization_header' },
	])
	if !(rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW'))) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The authorization header is missing'),
		]))
	} else if
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('user'), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('pwd'), rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW')))))) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('The authorization header is invalid'),
		]))
	} else {
		return var_result.clone()
	}
	var_result.array_set('status', 'recommended')
	var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
		rt.new_string('<p>%s</p>'),
		rt.call_function('__', [
			rt.new_string('If you are still seeing this warning after having tried the actions below, you may need to contact your hosting provider for further assistance.'),
		]),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('got_mod_rewrite'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/misc.php', '4')
	}
	if rt.is_true(rt.call_function('got_mod_rewrite', []rt.PhpVal{})) {
		var_result.array_get(rt.new_string('actions')) = rt.concat(var_result.array_get(rt.new_string('actions')), rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s">%s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('options-permalink.php')]),
			]),
			rt.call_function('__', [
				rt.new_string('Flush permalinks'),
			]),
		]))
	} else {
		var_result.array_get(rt.new_string('actions')) = rt.concat(var_result.array_get(rt.new_string('actions')), rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/rest-api/frequently-asked-questions/#why-is-authentication-not-working'),
			]),
			rt.call_function('__', [
				rt.new_string('Learn how to configure the Authorization header.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_page_cache() rt.PhpVal {
	mut var_description := rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Page cache enhances the speed and performance of your site by saving and serving static pages instead of calling for a page every time a user visits.')])).str() +
		'</p>')
	var_description = rt.concat(var_description, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('Page cache is detected by looking for an active page cache plugin as well as making three requests to the homepage and looking for one or more of the following HTTP client caching response headers:')])).str() +
		'</p>'))
	var_description = rt.concat(var_description, rt.new_string('<code>' +
		(rt.call_function('implode', [rt.new_string('</code>, <code>'), rt.func_array_keys(this.get_page_cache_headers())])).str() +
		'.</code>'))
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('wp_kses_post', [
			var_description.clone(),
		]) },
		rt.ArrayItem{ key: 'test', val: 'page_cache' },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'label', val: '' },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%1$s" target="_blank" rel="noreferrer">%2$s<span class="screen-reader-text"> %3$s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/advanced-administration/performance/optimization/#caching'),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about page cache'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
	])
	mut var_page_cache_detail := this.get_page_cache_detail()
	if rt.is_true(rt.call_function('is_wp_error', [var_page_cache_detail.clone()])) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Unable to detect the presence of page cache'),
		]))
		var_result.array_set('status', 'recommended')
		mut var_error_info := rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Unable to detect page cache due to possible loopback request problem. Please verify that the loopback request test is passing. Error: %1$s (Code: %2$s)'),
			]),
			rt.call_method(var_page_cache_detail, 'get_error_message', []rt.PhpVal{}),
			rt.call_method(var_page_cache_detail, 'get_error_code', []rt.PhpVal{}),
		])
		var_result.array_set('description',
			(rt.call_function('wp_kses_post', [rt.new_string('<p>${var_error_info.to_string()}</p>')])).str() +
			(var_result.array_get(rt.new_string('description'))).str())
		return var_result.clone()
	}
	var_result.array_set('status', var_page_cache_detail.array_get(rt.new_string('status')))
	mut switch_val_1 := var_page_cache_detail.array_get(rt.new_string('status'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('recommended'))) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Page cache is not detected but the server response time is OK'),
		]))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('good'))) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Page cache is detected and the server response time is good'),
		]))
	} else {
		if !rt.is_true(var_page_cache_detail.array_get(rt.new_string('headers')))
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_page_cache_detail.array_get(rt.new_string('advanced_cache_present')))))) {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Page cache is not detected and the server response time is slow'),
			]))
		} else {
			var_result.array_set('label', rt.call_function('__', [
				rt.new_string('Page cache is detected but the server response time is still slow'),
			]))
		}
	}
	mut var_page_cache_test_summary := map[string]rt.PhpVal{}
	if !rt.is_true(var_page_cache_detail.array_get(rt.new_string('response_time'))) {
		var_page_cache_test_summary <<
			'<span class="dashicons dashicons-dismiss" aria-hidden="true"></span> ' +(rt.call_function('__', [rt.new_string('Server response time could not be determined. Verify that loopback requests are working.')])).str()
	} else {
		mut var_threshold := rt.new_int(this.get_good_response_time_threshold())
		if rt.is_true(rt.less(var_page_cache_detail.array_get(rt.new_string('response_time')),
			var_threshold))
		{
			var_page_cache_test_summary <<
				'<span class="dashicons dashicons-yes-alt" aria-hidden="true"></span> ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Median server response time was %1$s milliseconds. This is less than the recommended %2$s milliseconds threshold.')]), rt.call_function('number_format_i18n', [var_page_cache_detail.array_get(rt.new_string('response_time'))]), rt.call_function('number_format_i18n', [var_threshold.clone()])])).str()
		} else {
			var_page_cache_test_summary <<
				'<span class="dashicons dashicons-warning" aria-hidden="true"></span> ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Median server response time was %1$s milliseconds. It should be less than the recommended %2$s milliseconds threshold.')]), rt.call_function('number_format_i18n', [var_page_cache_detail.array_get(rt.new_string('response_time'))]), rt.call_function('number_format_i18n', [var_threshold.clone()])])).str()
		}
		if !rt.is_true(var_page_cache_detail.array_get(rt.new_string('headers'))) {
			var_page_cache_test_summary <<
				'<span class="dashicons dashicons-warning" aria-hidden="true"></span> ' +(rt.call_function('__', [rt.new_string('No client caching response headers were detected.')])).str()
		} else {
			mut var_headers_summary :=
				rt.new_string('<span class="dashicons dashicons-yes-alt" aria-hidden="true"></span>')
			var_headers_summary = rt.concat(var_headers_summary,
				rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('There was %d client caching response header detected:'), rt.new_string('There were %d client caching response headers detected:'), rt.new_int(var_page_cache_detail.array_get(rt.new_string('headers')).array_count())]), rt.new_int(var_page_cache_detail.array_get(rt.new_string('headers')).array_count())])).str()))
			var_headers_summary = rt.concat(var_headers_summary, rt.new_string(' <code>' +
				(rt.call_function('implode', [rt.new_string('</code>, <code>'), var_page_cache_detail.array_get(rt.new_string('headers'))])).str() +
				'</code>.'))
			var_page_cache_test_summary << var_headers_summary.clone()
		}
	}
	if rt.is_true(var_page_cache_detail.array_get(rt.new_string('advanced_cache_present'))) {
		var_page_cache_test_summary <<
			'<span class="dashicons dashicons-yes-alt" aria-hidden="true"></span> ' +
			(rt.call_function('__', [rt.new_string('A page cache plugin was detected.')])).str()
	} else if !(var_page_cache_detail.clone().is_array()
		&& !(!rt.is_true(var_page_cache_detail.array_get(rt.new_string('headers'))))) {
		var_page_cache_test_summary <<
			'<span class="dashicons dashicons-warning" aria-hidden="true"></span> ' +
			(rt.call_function('__', [rt.new_string('A page cache plugin was not detected.')])).str()
	}
	var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.new_string(
		'<ul><li>' +
		(rt.call_function('implode', [rt.new_string('</li><li>'), rt.create_array_from_list(var_page_cache_test_summary)])).str() +
		'</li></ul>'))
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_persistent_object_cache() rt.PhpVal {
	mut var_action_url := rt.call_function('apply_filters', [
		rt.new_string('site_status_persistent_object_cache_url'),
		rt.call_function('__', [
			rt.new_string('https://developer.wordpress.org/advanced-administration/performance/optimization/#persistent-object-cache'),
		]),
	])
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'test', val: 'persistent_object_cache' },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('A persistent object cache is being used'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('A persistent object cache makes your site&#8217;s database more efficient, resulting in faster load times because WordPress can retrieve your site&#8217;s content and settings much more quickly.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				var_action_url.clone(),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about persistent object caching.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
	])
	if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) {
		return var_result.clone()
	}
	if !(this.should_suggest_persistent_object_cache()) {
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('A persistent object cache is not required'),
		]))
		return var_result.clone()
	}
	mut var_available_services := this.available_object_cache_services()
	mut var_notes := rt.call_function('__', [
		rt.new_string('Your hosting provider can tell you if a persistent object cache can be enabled on your site.'),
	])
	if !(!rt.is_true(var_available_services)) {
		var_notes = rt.concat(var_notes,
			rt.new_string(' ' +(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your host appears to support the following object caching services: %s.')]), rt.call_function('implode', [rt.new_string(', '), var_available_services.clone()])])).str()))
	}
	var_notes = rt.call_function('apply_filters', [
		rt.new_string('site_status_persistent_object_cache_notes'),
		var_notes.clone(),
		var_available_services.clone(),
	])
	var_result.array_set('status', 'recommended')
	var_result.array_set('label', rt.call_function('__', [
		rt.new_string('You should use a persistent object cache'),
	]))
	var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.call_function('sprintf', [
		rt.new_string('<p>%s</p>'),
		rt.call_function('wp_kses', [var_notes.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'a', val: rt.create_array([
					rt.ArrayItem{ key: 'href', val: true },
				]) },
				rt.ArrayItem{ key: 'code', val: true },
				rt.ArrayItem{ key: 'em', val: true },
				rt.ArrayItem{ key: 'strong', val: true },
			])]),
	]))
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_autoloaded_options_size() rt.PhpVal {
	mut var_alloptions := rt.call_function('wp_load_alloptions', []rt.PhpVal{})
	mut var_total_length := rt.new_int(0)
	mut iter_9 := var_alloptions.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_option_value := item_9.val
		if var_option_value.clone().is_array() || var_option_value.clone().is_object() {
			var_option_value = rt.call_function('maybe_serialize', [
				var_option_value.clone()])
		}
		var_total_length = rt.add(var_total_length, rt.new_int(var_option_value.str().len))
	}
	return var_total_length.clone()
}

fn (mut this Class_WP_Site_Health) get_test_autoloaded_options() rt.PhpVal {
	mut var_autoloaded_options_size := this.get_autoloaded_options_size()
	mut var_autoloaded_options_count := rt.new_int(rt.call_function('wp_load_alloptions',
		[]rt.PhpVal{}).array_count())
	mut var_base_description := rt.call_function('__', [
		rt.new_string('Autoloaded options are configuration settings for plugins and themes that are automatically loaded with every page load in WordPress. Having too many autoloaded options can slow down your site.'),
	])
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Autoloaded options are acceptable'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>' +
				(rt.call_function('esc_html', [var_base_description.clone()])).str() + ' ' +
				(rt.call_function('__', [rt.new_string('Your site has %1$s autoloaded options (size: %2$s) in the options table, which is acceptable.')])).str() +
				'</p>'),
			var_autoloaded_options_count.clone(),
			rt.call_function('size_format', [
				var_autoloaded_options_size.clone(),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: '' },
		rt.ArrayItem{ key: 'test', val: 'autoloaded_options' },
	])
	mut var_limit := rt.call_function('apply_filters', [
		rt.new_string('site_status_autoloaded_options_size_limit'),
		rt.new_int(800000),
	])
	if rt.is_true(rt.less(var_autoloaded_options_size, var_limit)) {
		return var_result.clone()
	}
	var_result.array_set('status', 'critical')
	var_result.array_set('label', rt.call_function('__', [
		rt.new_string('Autoloaded options could affect performance'),
	]))
	var_result.array_set('description', rt.call_function('sprintf', [
		rt.new_string('<p>' + (rt.call_function('esc_html', [var_base_description.clone()])).str() +
			' ' +
			(rt.call_function('__', [rt.new_string('Your site has %1$s autoloaded options (size: %2$s) in the options table, which could cause your site to be slow. You can review the options being autoloaded in your database and remove any options that are no longer needed by your site.')])).str() +
			'</p>'),
		var_autoloaded_options_count.clone(),
		rt.call_function('size_format', [var_autoloaded_options_size.clone()]),
	]))
	var_result.array_set('description', rt.call_function('apply_filters', [
		rt.new_string('site_status_autoloaded_options_limit_description'),
		var_result.array_get(rt.new_string('description')),
	]))
	var_result.array_set('actions', rt.call_function('sprintf', [
		rt.new_string('<p><a target="_blank" href="%1$s">%2$s</a></p>'),
		rt.call_function('esc_url', [
			rt.call_function('__', [
				rt.new_string('https://developer.wordpress.org/advanced-administration/performance/optimization/#autoloaded-options'),
			]),
		]),
		rt.call_function('__', [
			rt.new_string('More info about optimizing autoloaded options'),
		]),
	]))
	var_result.array_set('actions', rt.call_function('apply_filters', [
		rt.new_string('site_status_autoloaded_options_action_to_perform'),
		var_result.array_get(rt.new_string('actions')),
	]))
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_search_engine_visibility() rt.PhpVal {
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Search engine indexing is enabled.'),
			rt.new_string('default'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Privacy'),
				rt.new_string('default'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Search engines can crawl and index your site. No action needed.'),
				rt.new_string('default'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%1$s">%2$s</a></p>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [
					rt.new_string('options-reading.php#blog_public'),
				]),
			]),
			rt.call_function('__', [
				rt.new_string('Review your visibility settings'),
				rt.new_string('default'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'search_engine_visibility' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
		rt.new_string('blog_public'),
	])))))
	{
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Search engines are discouraged from indexing this site.'),
			rt.new_string('default'),
		]))
		var_result.array_get_mut('badge').array_set('color', 'blue')
		var_result.array_set('description', rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Your site is hidden from search engines. Consider enabling indexing if this is a public site.'),
				rt.new_string('default'),
			]),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Site_Health) get_test_opcode_cache() rt.PhpVal {
	mut var_opcode_cache_enabled := rt.new_bool(false)
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('opcache_get_status'),
	]))
	{
		mut var_status := rt.call_function('opcache_get_status', [
			rt.new_bool(false)])
		if rt.is_true(var_status)
			&& rt.is_true(rt.identical(rt.new_bool(true), var_status.array_get(rt.new_string('opcache_enabled')))) {
			var_opcode_cache_enabled = rt.new_bool(true)
		}
	}
	mut var_result := rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Opcode cache is enabled'),
		]) },
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'badge', val: rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Performance'),
			]) },
			rt.ArrayItem{ key: 'color', val: 'blue' },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
			rt.new_string('<p>%s</p>'),
			rt.call_function('__', [
				rt.new_string('Opcode cache improves PHP performance by storing precompiled script bytecode in memory, reducing the need for PHP to load and parse scripts on each request.'),
			]),
		]) },
		rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [
			rt.new_string('<p><a href="%s" target="_blank">%s<span class="screen-reader-text"> %s</span><span aria-hidden="true" class="dashicons dashicons-external"></span></a></p>'),
			rt.call_function('esc_url', [
				rt.new_string('https://www.php.net/manual/en/book.opcache.php'),
			]),
			rt.call_function('__', [
				rt.new_string('Learn more about OPcache.'),
			]),
			rt.call_function('__', [
				rt.new_string('(opens in a new tab)'),
			]),
		]) },
		rt.ArrayItem{ key: 'test', val: 'opcode_cache' },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_opcode_cache_enabled)))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [
			rt.new_string('Opcode cache is not enabled'),
		]))
		var_result.array_get(rt.new_string('description')) = rt.concat(var_result.array_get(rt.new_string('description')), rt.new_string(
			'<p>' +
			(rt.call_function('__', [rt.new_string('Enabling this cache can significantly improve the performance of your site.')])).str() +
			'</p>'))
	}
	return var_result.clone()
}

fn Class_WP_Site_Health.get_tests() rt.PhpVal {
	mut var_tests := rt.create_array([
		rt.ArrayItem{ key: 'direct', val: rt.create_array([
			rt.ArrayItem{ key: 'wordpress_version', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('WordPress Version'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'wordpress_version' },
			]) },
			rt.ArrayItem{ key: 'plugin_version', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Plugin Versions'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'plugin_version' },
			]) },
			rt.ArrayItem{ key: 'theme_version', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Theme Versions'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'theme_version' },
			]) },
			rt.ArrayItem{ key: 'php_version', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP Version'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'php_version' },
			]) },
			rt.ArrayItem{ key: 'php_extensions', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP Extensions'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'php_extensions' },
			]) },
			rt.ArrayItem{ key: 'php_default_timezone', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP Default Timezone'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'php_default_timezone' },
			]) },
			rt.ArrayItem{ key: 'php_sessions', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('PHP Sessions'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'php_sessions' },
			]) },
			rt.ArrayItem{ key: 'sql_server', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Database Server version'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'sql_server' },
			]) },
			rt.ArrayItem{ key: 'ssl_support', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Secure communication'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'ssl_support' },
			]) },
			rt.ArrayItem{ key: 'scheduled_events', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Scheduled events'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'scheduled_events' },
			]) },
			rt.ArrayItem{ key: 'http_requests', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('HTTP Requests'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'http_requests' },
			]) },
			rt.ArrayItem{ key: 'rest_availability', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('REST API availability'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'rest_availability' },
				rt.ArrayItem{ key: 'skip_cron', val: true },
			]) },
			rt.ArrayItem{ key: 'debug_enabled', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Debugging enabled'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'is_in_debug_mode' },
			]) },
			rt.ArrayItem{ key: 'file_uploads', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('File uploads'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'file_uploads' },
			]) },
			rt.ArrayItem{ key: 'plugin_theme_auto_updates', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Plugin and theme auto-updates'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'plugin_theme_auto_updates' },
			]) },
			rt.ArrayItem{ key: 'update_temp_backup_writable', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Plugin and theme temporary backup directory access'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'update_temp_backup_writable' },
			]) },
			rt.ArrayItem{ key: 'available_updates_disk_space', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Available disk space'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'available_updates_disk_space' },
			]) },
			rt.ArrayItem{ key: 'autoloaded_options', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Autoloaded options'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'autoloaded_options' },
			]) },
			rt.ArrayItem{ key: 'insecure_registration', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Open Registration with privileged default role'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'insecure_registration' },
			]) },
			rt.ArrayItem{ key: 'search_engine_visibility', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Search Engine Visibility'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'search_engine_visibility' },
			]) },
			rt.ArrayItem{ key: 'opcode_cache', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Opcode cache'),
				]) },
				rt.ArrayItem{ key: 'test', val: 'opcode_cache' },
			]) },
		]) },
		rt.ArrayItem{ key: 'async', val: rt.create_array([
			rt.ArrayItem{ key: 'dotorg_communication', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Communication with WordPress.org'),
				]) },
				rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
					rt.new_string('wp-site-health/v1/tests/dotorg-communication'),
				]) },
				rt.ArrayItem{ key: 'has_rest', val: true },
				rt.ArrayItem{ key: 'async_direct_test', val: rt.create_array([
					rt.ArrayItem{ key: none, val: Class_WP_Site_Health.get_instance() },
					rt.ArrayItem{ key: none, val: 'get_test_dotorg_communication' },
				]) },
			]) },
			rt.ArrayItem{ key: 'background_updates', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Background updates'),
				]) },
				rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
					rt.new_string('wp-site-health/v1/tests/background-updates'),
				]) },
				rt.ArrayItem{ key: 'has_rest', val: true },
				rt.ArrayItem{ key: 'async_direct_test', val: rt.create_array([
					rt.ArrayItem{ key: none, val: Class_WP_Site_Health.get_instance() },
					rt.ArrayItem{ key: none, val: 'get_test_background_updates' },
				]) },
			]) },
			rt.ArrayItem{ key: 'loopback_requests', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Loopback request'),
				]) },
				rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
					rt.new_string('wp-site-health/v1/tests/loopback-requests'),
				]) },
				rt.ArrayItem{ key: 'has_rest', val: true },
				rt.ArrayItem{ key: 'async_direct_test', val: rt.create_array([
					rt.ArrayItem{ key: none, val: Class_WP_Site_Health.get_instance() },
					rt.ArrayItem{ key: none, val: 'get_test_loopback_requests' },
				]) },
			]) },
			rt.ArrayItem{ key: 'https_status', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('HTTPS status'),
				]) },
				rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
					rt.new_string('wp-site-health/v1/tests/https-status'),
				]) },
				rt.ArrayItem{ key: 'has_rest', val: true },
				rt.ArrayItem{ key: 'async_direct_test', val: rt.create_array([
					rt.ArrayItem{ key: none, val: Class_WP_Site_Health.get_instance() },
					rt.ArrayItem{ key: none, val: 'get_test_https_status' },
				]) },
			]) },
		]) },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_site_protected_by_basic_auth',
		[]rt.PhpVal{})))))
	{
		var_tests.array_get_mut('async').array_set('authorization_header', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Authorization header'),
			]) },
			rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
				rt.new_string('wp-site-health/v1/tests/authorization-header'),
			]) },
			rt.ArrayItem{ key: 'has_rest', val: true },
			rt.ArrayItem{ key: 'headers', val: rt.create_array([
				rt.ArrayItem{ key: 'Authorization', val: 'Basic ' +
					(rt.call_function('base64_encode', [rt.new_string('user:pwd')])).str() },
			]) },
			rt.ArrayItem{ key: 'skip_cron', val: true },
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('production'), rt.call_function('wp_get_environment_type',
		[]rt.PhpVal{})))
	{
		var_tests.array_get_mut('async').array_set('page_cache', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Page cache'),
			]) },
			rt.ArrayItem{ key: 'test', val: rt.call_function('rest_url', [
				rt.new_string('wp-site-health/v1/tests/page-cache'),
			]) },
			rt.ArrayItem{ key: 'has_rest', val: true },
			rt.ArrayItem{ key: 'async_direct_test', val: rt.create_array([
				rt.ArrayItem{ key: none, val: Class_WP_Site_Health.get_instance() },
				rt.ArrayItem{ key: none, val: 'get_test_page_cache' },
			]) },
		]))
		var_tests.array_get_mut('direct').array_set('persistent_object_cache', rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Persistent object cache'),
			]) },
			rt.ArrayItem{ key: 'test', val: 'persistent_object_cache' },
		]))
	}
	var_tests = rt.call_function('apply_filters', [rt.new_string('site_status_tests'),
		var_tests.clone()])
	var_tests = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{
			key: 'direct'
			val: map[string]rt.PhpVal{}
		}, rt.ArrayItem{
			key: 'async'
			val: map[string]rt.PhpVal{}
		}]),
		var_tests.clone(),
	])
	return var_tests.clone()
}

fn (mut this Class_WP_Site_Health) admin_body_class(var_body_class rt.PhpVal) rt.PhpVal {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('site-health'), rt.get_property(var_screen,
		'id')))))
	{
		return var_body_class.clone()
	}
	var_body_class = rt.concat(var_body_class, rt.new_string(' site-health'))
	return var_body_class.clone()
}

fn (mut this Class_WP_Site_Health) wp_schedule_test_init() {
	this.schedules = rt.call_function('wp_get_schedules', []rt.PhpVal{})
	this.get_cron_tasks()
}

fn (mut this Class_WP_Site_Health) get_cron_tasks() {
	mut var_cron_tasks := rt.call_function('_get_cron_array', []rt.PhpVal{})
	if !rt.is_true(var_cron_tasks) {
		this.crons = create_wp_error(rt.new_string('no_tasks'), rt.call_function('__', [
			rt.new_string('No scheduled events exist on this site.'),
		]))
		return
	}
	this.crons = map[string]rt.PhpVal{}
	mut iter_10 := var_cron_tasks.iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_cron := item_10.val
		mut var_time := item_10.key
		mut iter_11 := var_cron.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_dings := item_11.val
			mut var_hook := item_11.key
			mut iter_12 := var_dings.iterator()
			for {
				item_12 := iter_12.next() or { break }
				mut var_data := item_12.val
				mut var_sig := item_12.key
				this.crons.array_set('${var_hook.to_string()}-${var_sig.to_string()}-${var_time.to_string()}', rt.array_to_object(rt.create_array([
					rt.ArrayItem{ key: 'hook', val: var_hook },
					rt.ArrayItem{ key: 'time', val: var_time },
					rt.ArrayItem{ key: 'sig', val: var_sig },
					rt.ArrayItem{ key: 'args', val: var_data.array_get(rt.new_string('args')) },
					rt.ArrayItem{
						key: 'schedule'
						val: var_data.array_get(rt.new_string('schedule'))
					},
					rt.ArrayItem{
						key: 'interval'
						val: if !(var_data.array_get(rt.new_string('interval'))).is_null() {
							var_data.array_get(rt.new_string('interval'))
						} else {
							rt.new_null()
						}
					},
				])))
			}
		}
	}
}

fn (mut this Class_WP_Site_Health) has_missed_cron() bool {
	if rt.is_true(rt.call_function('is_wp_error', [this.crons])) {
		return (this.crons).to_bool()
	}
	mut iter_13 := this.crons.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_cron := item_13.val
		mut var_id := item_13.key
		if rt.is_true(rt.less(rt.sub(rt.get_property(var_cron, 'time'), rt.call_function('time',
			[]rt.PhpVal{})), this.timeout_missed_cron))
		{
			this.last_missed_cron = rt.get_property(var_cron, 'hook')
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Site_Health) has_late_cron() bool {
	if rt.is_true(rt.call_function('is_wp_error', [this.crons])) {
		return (this.crons).to_bool()
	}
	mut iter_14 := this.crons.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_cron := item_14.val
		mut var_id := item_14.key
		mut var_cron_offset := rt.sub(rt.get_property(var_cron, 'time'), rt.call_function('time',
			[]rt.PhpVal{}))
		if rt.is_true(rt.greater_equal(var_cron_offset, this.timeout_missed_cron))
			&& rt.is_true(rt.less(var_cron_offset, this.timeout_late_cron)) {
			this.last_late_cron = rt.get_property(var_cron, 'hook')
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Site_Health) detect_plugin_theme_auto_update_issues() rt.PhpVal {
	mut var_mock_plugin := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'w.org/plugins/a-fake-plugin' },
		rt.ArrayItem{ key: 'slug', val: 'a-fake-plugin' },
		rt.ArrayItem{ key: 'plugin', val: 'a-fake-plugin/a-fake-plugin.php' },
		rt.ArrayItem{ key: 'new_version', val: '9.9' },
		rt.ArrayItem{ key: 'url', val: 'https://wordpress.org/plugins/a-fake-plugin/' },
		rt.ArrayItem{
			key: 'package'
			val: 'https://downloads.wordpress.org/plugin/a-fake-plugin.9.9.zip'
		},
		rt.ArrayItem{ key: 'icons', val: rt.create_array([
			rt.ArrayItem{ key: '2x', val: 'https://ps.w.org/a-fake-plugin/assets/icon-256x256.png' },
			rt.ArrayItem{ key: '1x', val: 'https://ps.w.org/a-fake-plugin/assets/icon-128x128.png' },
		]) },
		rt.ArrayItem{ key: 'banners', val: rt.create_array([
			rt.ArrayItem{
				key: '2x'
				val: 'https://ps.w.org/a-fake-plugin/assets/banner-1544x500.png'
			},
			rt.ArrayItem{ key: '1x', val: 'https://ps.w.org/a-fake-plugin/assets/banner-772x250.png' },
		]) },
		rt.ArrayItem{
			key: 'banners_rtl'
			val: map[string]rt.PhpVal{}
		},
		rt.ArrayItem{ key: 'tested', val: '5.5.0' },
		rt.ArrayItem{ key: 'requires_php', val: '5.6.20' },
		rt.ArrayItem{ key: 'compatibility', val: create_stdclass() },
	]))
	mut var_mock_theme := rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'theme', val: 'a-fake-theme' },
		rt.ArrayItem{ key: 'new_version', val: '9.9' },
		rt.ArrayItem{ key: 'url', val: 'https://wordpress.org/themes/a-fake-theme/' },
		rt.ArrayItem{
			key: 'package'
			val: 'https://downloads.wordpress.org/theme/a-fake-theme.9.9.zip'
		},
		rt.ArrayItem{ key: 'requires', val: '5.0.0' },
		rt.ArrayItem{ key: 'requires_php', val: '5.6.20' },
	]))
	mut var_test_plugins_enabled := rt.call_function('wp_is_auto_update_forced_for_item', [
		rt.new_string('plugin'),
		rt.new_bool(true),
		var_mock_plugin.clone(),
	])
	mut var_test_themes_enabled := rt.call_function('wp_is_auto_update_forced_for_item', [
		rt.new_string('theme'),
		rt.new_bool(true),
		var_mock_theme.clone(),
	])
	mut var_ui_enabled_for_plugins := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('plugin'),
	])
	mut var_ui_enabled_for_themes := rt.call_function('wp_is_auto_update_enabled_for_type', [
		rt.new_string('theme'),
	])
	mut var_plugin_filter_present := rt.call_function('has_filter', [
		rt.new_string('auto_update_plugin'),
	])
	mut var_theme_filter_present := rt.call_function('has_filter', [
		rt.new_string('auto_update_theme'),
	])
	if (rt.is_true(rt.new_bool(!(rt.is_true(var_test_plugins_enabled))))
		&& rt.is_true(var_ui_enabled_for_plugins))
		|| (rt.is_true(rt.new_bool(!(rt.is_true(var_test_themes_enabled))))
		&& rt.is_true(var_ui_enabled_for_themes)) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'critical' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Auto-updates for plugins and/or themes appear to be disabled, but settings are still set to be displayed. This could cause auto-updates to not work as expected.'),
			]) },
		]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_test_plugins_enabled))))
		&& rt.is_true(var_plugin_filter_present)
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_test_themes_enabled))))
		&& rt.is_true(var_theme_filter_present) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'recommended' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Auto-updates for plugins and themes appear to be disabled. This will prevent your site from receiving new versions automatically when available.'),
			]) },
		]))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_test_plugins_enabled))))
		&& rt.is_true(var_plugin_filter_present) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'recommended' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Auto-updates for plugins appear to be disabled. This will prevent your site from receiving new versions automatically when available.'),
			]) },
		]))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_test_themes_enabled))))
		&& rt.is_true(var_theme_filter_present) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'recommended' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
				rt.new_string('Auto-updates for themes appear to be disabled. This will prevent your site from receiving new versions automatically when available.'),
			]) },
		]))
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
			rt.new_string('There appear to be no issues with plugin and theme auto-updates.'),
		]) },
	]))
}

fn (mut this Class_WP_Site_Health) can_perform_loopback() rt.PhpVal {
	mut var_body := {
		'site-health': 'loopback-test'
	}
	mut var_cookies := rt.call_function('wp_unslash', [rt.get_superglobal('_COOKIE').clone()])
	mut var_timeout := rt.new_int(10)
	mut var_headers := rt.create_array([
		rt.ArrayItem{ key: 'Cache-Control', val: 'no-cache' },
	])
	mut var_sslverify := rt.call_function('apply_filters', [
		rt.new_string('https_local_ssl_verify'),
		rt.new_bool(false),
	])
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		var_headers.array_set('Authorization', 'Basic ' +
			(rt.call_function('base64_encode', [rt.new_string((rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))])).str() +
			':' +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))])).str())])).str())
	}
	mut var_url := rt.call_function('site_url', [rt.new_string('wp-cron.php')])
	mut var_r := rt.call_function('wp_remote_post', [var_url.clone(),
		rt.call_function('compact', [rt.new_string('body'), rt.new_string('cookies'),
			rt.new_string('headers'), rt.new_string('timeout'),
			rt.new_string('sslverify')])])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'critical' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
				rt.new_string('%s<br>%s'),
				rt.call_function('__', [
					rt.new_string('The loopback request to your site failed, this means features relying on them are not currently working as expected.'),
				]),
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Error: %1$s (%2$s)')]),
					rt.call_method(var_r, 'get_error_message', []rt.PhpVal{}),
					rt.call_method(var_r, 'get_error_code', []rt.PhpVal{}),
				]),
			]) },
		]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [
		var_r.clone(),
	])))))
	{
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'status', val: 'recommended' },
			rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The loopback request returned an unexpected http status code, %d, it was not possible to determine if this will prevent features from working as expected.'),
				]),
				rt.call_function('wp_remote_retrieve_response_code', [
					var_r.clone(),
				]),
			]) },
		]))
	}
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'status', val: 'good' },
		rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
			rt.new_string('The loopback request to your site completed successfully.'),
		]) },
	]))
}

fn (mut this Class_WP_Site_Health) maybe_create_scheduled_event() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_site_health_scheduled_check')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('DAY_IN_SECONDS')),
			rt.new_string('weekly'),
			rt.new_string('wp_site_health_scheduled_check'),
		])
	}
}

fn (mut this Class_WP_Site_Health) wp_cron_scheduled_check() {
	rt.include_file((rt.call_function('trailingslashit', [rt.get_constant('ABSPATH')])).str() +
		'wp-admin/includes/admin.php', '4')
	mut var_tests := Class_WP_Site_Health.get_tests()
	mut var_results := map[string]rt.PhpVal{}
	mut var_site_status := {
		'good':        0
		'recommended': 0
		'critical':    0
	}
	if rt.is_true(this.is_development_environment()) {
		var_tests.array_get(rt.new_string('async')).array_unset(rt.new_string('https_status'))
	}
	mut iter_15 := var_tests.array_get(rt.new_string('direct')).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_test := item_15.val
		if !(!rt.is_true(var_test.array_get(rt.new_string('skip_cron')))) {
			continue
		}
		if rt.is_true(rt.new_bool(var_test.array_get(rt.new_string('test')).is_string())) {
			mut var_test_function := rt.call_function('sprintf', [
				rt.new_string('get_test_%s'),
				var_test.array_get(rt.new_string('test')),
			])
			if rt.is_true(rt.call_function('method_exists', [rt.new_object('WP_Site_Health', []string{}, &this), var_test_function.clone()]))
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: rt.new_object('WP_Site_Health', []string{}, &this)
			}, rt.ArrayItem{ key: none, val: var_test_function }])]) {
				var_results.array_push(this.perform_test(rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) },
					rt.ArrayItem{ key: none, val: var_test_function },
				])))
				continue
			}
		}
		if rt.is_true(rt.call_function('is_callable', [
			var_test.array_get(rt.new_string('test')),
		]))
		{
			var_results.array_push(this.perform_test(var_test.array_get(rt.new_string('test'))))
		}
	}
	mut iter_16 := var_tests.array_get(rt.new_string('async')).iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_test := item_16.val
		if !(!rt.is_true(var_test.array_get(rt.new_string('skip_cron')))) {
			continue
		}
		if !(!rt.is_true(var_test.array_get(rt.new_string('async_direct_test'))))
			&& rt.call_function('is_callable', [var_test.array_get(rt.new_string('async_direct_test'))]) {
			var_results.array_push(this.perform_test(var_test.array_get(rt.new_string('async_direct_test'))))
			continue
		}
		if rt.is_true(rt.new_bool(var_test.array_get(rt.new_string('test')).is_string())) {
			if var_test.array_isset(rt.new_string('has_rest'))
				&& rt.is_true(var_test.array_get(rt.new_string('has_rest'))) {
				mut var_result_fetch := rt.call_function('wp_remote_get', [
					var_test.array_get(rt.new_string('test')),
					rt.create_array([
						rt.ArrayItem{ key: 'body', val: rt.create_array([
							rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
								rt.new_string('wp_rest'),
							]) },
						]) },
					]),
				])
			} else {
				var_result_fetch = rt.call_function('wp_remote_post', [
					rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]),
					rt.create_array([rt.ArrayItem{ key: 'body', val: rt.create_array([
						rt.ArrayItem{ key: 'action', val: var_test.array_get(rt.new_string('test')) },
						rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
							rt.new_string('health-check-site-status'),
						]) },
					]) }]),
				])
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result_fetch.clone()])))))
				&& rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_result_fetch.clone()]))) {
				mut var_result := rt.call_function('json_decode', [
					rt.call_function('wp_remote_retrieve_body', [
						var_result_fetch.clone()]),
					rt.new_bool(true),
				])
			} else {
				var_result = rt.new_bool(false)
			}
			if rt.is_true(rt.new_bool(var_result.clone().is_array())) {
				var_results.array_push(var_result.clone())
			} else {
				var_results.array_push(rt.create_array([
					rt.ArrayItem{ key: 'status', val: 'recommended' },
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('A test is unavailable'),
					]) },
				]))
			}
		}
	}
	mut iter_17 := var_results.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_result := item_17.val
		if rt.is_true(rt.identical(rt.new_string('critical'),
			var_result.array_get(rt.new_string('status'))))
		{
			rt.pre_inc(rt.new_int(var_site_status['critical']))
		} else if rt.is_true(rt.identical(rt.new_string('recommended'),
			var_result.array_get(rt.new_string('status'))))
		{
			rt.pre_inc(rt.new_int(var_site_status['recommended']))
		} else {
			rt.pre_inc(rt.new_int(var_site_status['good']))
		}
	}
	rt.call_function('set_transient', [rt.new_string('health-check-site-status-result'),
		rt.call_function('wp_json_encode', [
			rt.create_array_from_native_map(var_site_status),
		])])
}

fn (mut this Class_WP_Site_Health) is_development_environment() rt.PhpVal {
	return rt.call_function('in_array', [
		rt.call_function('wp_get_environment_type', []rt.PhpVal{}),
		rt.create_array([rt.ArrayItem{ key: none, val: 'development' },
			rt.ArrayItem{ key: none, val: 'local' }]),
		rt.new_bool(true),
	])
}

fn (mut this Class_WP_Site_Health) get_page_cache_headers() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_int(1), rt.call_function('preg_match', [
			rt.new_string('/(^| |,)HIT(,| |$)/i'),
			var_header_value.clone(),
		]))
	}
	mut var_cache_hit_callback := rt.new_closure(closure_2_fn)
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool((rt.call_function('preg_match', [
			rt.new_string('/max-age=[1-9]/'),
			var_header_value.clone(),
		])).to_bool())
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.greater(rt.call_function('strtotime', [var_header_value.clone()]), rt.call_function('time',
			[]rt.PhpVal{}))
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_header_value.clone().is_long()
			|| var_header_value.clone().is_double()
			&& rt.is_true(rt.greater(var_header_value, rt.new_int(0))))
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('true'),
			rt.new_string(var_header_value.clone().to_string().to_lower()))
	}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool('on' != var_header_value.clone().to_string().to_lower())
	}
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string('store'),
			rt.new_string(var_header_value.clone().to_string().to_lower()))
	}
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_header_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_int(1), rt.call_function('preg_match', [
			rt.new_string('/^\\d+ \\d+/'),
			var_header_value.clone(),
		]))
	}
	mut var_cache_headers := {
		'cache-control':          rt.new_closure(closure_3_fn)
		'expires':                rt.new_closure(closure_4_fn)
		'age':                    rt.new_closure(closure_5_fn)
		'last-modified':          rt.new_null()
		'etag':                   rt.new_null()
		'via':                    rt.new_null()
		'x-cache-enabled':        rt.new_closure(closure_6_fn)
		'x-cache-disabled':       rt.new_closure(closure_7_fn)
		'cf-cache-status':        var_cache_hit_callback
		'x-cache':                var_cache_hit_callback
		'x-litespeed-cache':      var_cache_hit_callback
		'x-srcache-store-status': rt.new_closure(closure_8_fn)
		'x-srcache-fetch-status': var_cache_hit_callback
		'x-cache-status':         var_cache_hit_callback
		'x-proxy-cache':          var_cache_hit_callback
		'x-varnish':              rt.new_closure(closure_9_fn)
	}
	return rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('site_status_page_cache_supported_cache_headers'),
		rt.create_array_from_native_map(var_cache_headers),
	]))
}

fn (mut this Class_WP_Site_Health) check_for_page_caching() rt.PhpVal {
	mut var_sslverify := rt.call_function('apply_filters', [
		rt.new_string('https_local_ssl_verify'),
		rt.new_bool(false),
	])
	mut var_headers := map[string]rt.PhpVal{}
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_USER'))
		&& rt.get_superglobal('_SERVER').array_isset(rt.new_string('PHP_AUTH_PW')) {
		var_headers.array_set('Authorization', 'Basic ' +
			(rt.call_function('base64_encode', [rt.new_string((rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_USER'))])).str() +
			':' +(rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_AUTH_PW'))])).str())])).str())
	}
	mut var_caching_headers := this.get_page_cache_headers()
	mut var_page_caching_response_headers := map[string]rt.PhpVal{}
	mut var_response_timing := map[string]rt.PhpVal{}
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, rt.new_int(3)))) { break
		 }
		mut var_start_time := rt.call_function('microtime', [
			rt.new_bool(true)])
		mut var_http_response := rt.call_function('wp_remote_get', [
			rt.call_function('home_url', [rt.new_string('/')]),
			rt.call_function('compact', [rt.new_string('sslverify'),
				rt.new_string('headers')]),
		])
		mut var_end_time := rt.call_function('microtime', [rt.new_bool(true)])
		if rt.is_true(rt.call_function('is_wp_error', [var_http_response.clone()])) {
			return var_http_response.clone()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_remote_retrieve_response_code', [
			var_http_response.clone(),
		]), rt.new_int(200)))))
		{
			return create_wp_error('http_' +(rt.call_function('wp_remote_retrieve_response_code', [var_http_response.clone()])).str(), rt.call_function('wp_remote_retrieve_response_message', [
				var_http_response.clone(),
			]))
		}
		mut var_response_headers := map[string]rt.PhpVal{}
		mut iter_18 := var_caching_headers.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_callback := item_18.val
			mut var_header := item_18.key
			mut var_header_values := rt.call_function('wp_remote_retrieve_header', [
				var_http_response.clone(),
				var_header.clone(),
			])
			if !rt.is_true(var_header_values) {
				continue
			}
			var_header_values = rt.cast_array(var_header_values)
			if !rt.is_true(var_callback)
				|| (rt.call_function('is_callable', [var_callback.clone()])
				&& rt.call_function('array_filter', [var_header_values.clone(), var_callback.clone()]).array_count() > 0) {
				var_response_headers.array_set(var_header, var_header_values.clone())
			}
		}
		var_page_caching_response_headers << var_response_headers.clone()
		var_response_timing << rt.mul(rt.sub(var_end_time, var_start_time), rt.new_int(1000))
		rt.post_inc(var_i)
	}
	return rt.create_array([
		rt.ArrayItem{
			key: 'advanced_cache_present'
			val:
				rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/advanced-cache.php')]))
				&& rt.is_true(rt.call_function('defined', [rt.new_string('WP_CACHE')]))
				&& rt.is_true(rt.get_constant('WP_CACHE'))
				&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('enable_loading_advanced_cache_dropin'), rt.new_bool(true)]))
		},
		rt.ArrayItem{ key: 'page_caching_response_headers', val: var_page_caching_response_headers },
		rt.ArrayItem{ key: 'response_timing', val: var_response_timing },
	])
}

fn (mut this Class_WP_Site_Health) get_page_cache_detail() rt.PhpVal {
	mut var_page_cache_detail := this.check_for_page_caching()
	if rt.is_true(rt.call_function('is_wp_error', [var_page_cache_detail.clone()])) {
		return var_page_cache_detail.clone()
	}
	mut var_response_timings := var_page_cache_detail.array_get(rt.new_string('response_timing'))
	rt.call_function('rsort', [var_response_timings.clone()])
	mut var_page_speed := var_response_timings.array_get(rt.call_function('floor', [
		rt.new_int(var_response_timings.clone().array_count() / 2),
	]))
	mut var_headers := map[string]rt.PhpVal{}
	mut iter_19 :=
		var_page_cache_detail.array_get(rt.new_string('page_caching_response_headers')).iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_page_caching_response_headers := item_19.val
		var_headers = rt.call_function('array_merge', [var_headers.clone(),
			rt.func_array_keys(var_page_caching_response_headers.clone())])
	}
	var_headers = rt.call_function('array_unique', [var_headers.clone()])
	mut var_has_page_caching := rt.new_bool(var_headers.clone().array_count() > 0
		|| rt.is_true(var_page_cache_detail.array_get(rt.new_string('advanced_cache_present'))))
	if rt.is_true(var_page_speed)
		&& rt.is_true(rt.less(var_page_speed, this.get_good_response_time_threshold())) {
		mut var_result := rt.new_string((if rt.is_true(var_has_page_caching) {
			'good'
		} else {
			'recommended'
		}).str())
	} else {
		var_result = rt.new_string('critical')
	}
	return rt.create_array([rt.ArrayItem{ key: 'status', val: var_result },
		rt.ArrayItem{
			key: 'advanced_cache_present'
			val: var_page_cache_detail.array_get(rt.new_string('advanced_cache_present'))
		}, rt.ArrayItem{ key: 'headers', val: var_headers }, rt.ArrayItem{
			key: 'response_time'
			val: var_page_speed
		}])
}

fn (mut this Class_WP_Site_Health) get_good_response_time_threshold() i64 {
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('site_status_good_response_time_threshold'),
		rt.new_int(600),
	])).to_i64())
}

fn (mut this Class_WP_Site_Health) should_suggest_persistent_object_cache() bool {
	mut var_wpdb := rt.new_null()
	mut var_short_circuit := rt.call_function('apply_filters', [
		rt.new_string('site_status_should_suggest_persistent_object_cache'),
		rt.new_null(),
	])
	if rt.is_true(rt.new_bool(var_short_circuit.clone().is_bool())) {
		return var_short_circuit.to_bool()
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return true
	}
	mut var_thresholds := rt.call_function('apply_filters', [
		rt.new_string('site_status_persistent_object_cache_thresholds'),
		rt.create_array([rt.ArrayItem{ key: 'alloptions_count', val: 500 },
			rt.ArrayItem{ key: 'alloptions_bytes', val: 100000 },
			rt.ArrayItem{ key: 'comments_count', val: 1000 },
			rt.ArrayItem{ key: 'options_count', val: 1000 }, rt.ArrayItem{
				key: 'posts_count'
				val: 1000
			}, rt.ArrayItem{ key: 'terms_count', val: 1000 },
			rt.ArrayItem{ key: 'users_count', val: 1000 }]),
	])
	mut var_alloptions := rt.call_function('wp_load_alloptions', []rt.PhpVal{})
	if rt.is_true(rt.less(var_thresholds.array_get(rt.new_string('alloptions_count')),
		rt.new_int(var_alloptions.clone().array_count())))
	{
		return true
	}
	if rt.is_true(rt.less(var_thresholds.array_get(rt.new_string('alloptions_bytes')), rt.new_int(rt.call_function('serialize', [
		var_alloptions.clone(),
	]).to_string().len)))
	{
		return true
	}
	mut var_table_names := rt.call_function('implode', [rt.new_string("','"),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'comments') },
			rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'options') },
			rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'posts') },
			rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'terms') },
			rt.ArrayItem{ key: none, val: rt.get_property(var_wpdb, 'users') },
		])])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT TABLE_NAME AS 'table', TABLE_ROWS AS 'rows', SUM(data_length + index_length) as 'bytes' FROM information_schema.TABLES WHERE TABLE_SCHEMA = %s AND TABLE_NAME IN ('${var_table_names.to_string()}') GROUP BY TABLE_NAME;"),
			rt.get_constant('DB_NAME'),
		]),
		rt.get_constant('OBJECT_K'),
	])
	mut var_threshold_map := {
		'comments_count': rt.get_property(var_wpdb, 'comments')
		'options_count':  rt.get_property(var_wpdb, 'options')
		'posts_count':    rt.get_property(var_wpdb, 'posts')
		'terms_count':    rt.get_property(var_wpdb, 'terms')
		'users_count':    rt.get_property(var_wpdb, 'users')
	}
	for var_threshold, var_table in var_threshold_map {
		if rt.is_true(rt.less_equal(var_thresholds.array_get(rt.new_string(threshold)), rt.get_property(var_results.array_get(var_table),
			'rows')))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Site_Health) available_object_cache_services() rt.PhpVal {
	mut var_extensions := rt.call_function('array_map', [
		rt.new_string('extension_loaded'),
		rt.create_array([rt.ArrayItem{ key: 'APCu', val: 'apcu' },
			rt.ArrayItem{ key: 'Redis', val: 'redis' }, rt.ArrayItem{ key: 'Relay', val: 'relay' },
			rt.ArrayItem{ key: 'Memcache', val: 'memcache' },
			rt.ArrayItem{ key: 'Memcached', val: 'memcached' }]),
	])
	mut var_services := rt.func_array_keys(rt.call_function('array_filter', [
		var_extensions.clone()]))
	return rt.call_function('apply_filters', [
		rt.new_string('site_status_available_object_cache_services'),
		var_services.clone(),
	])
}

struct Class_WP_Theme {
	rt.PhpObjectBase
}

struct Class_WP_Site_Health_Auto_Updates {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase:                rt.PhpObjectBase{}
		is_acceptable_mysql_version:  rt.new_null()
		is_recommended_mysql_version: rt.new_null()
		is_mariadb:                   false
		mysql_server_version:         rt.new_string('')
		mysql_required_version:       rt.new_string('5.5')
		mysql_recommended_version:    rt.new_string('8.0')
		mariadb_recommended_version:  rt.new_string('10.6')
		php_memory_limit:             rt.new_null()
		schedules:                    rt.new_null()
		crons:                        rt.new_null()
		last_missed_cron:             rt.new_null()
		last_late_cron:               rt.new_null()
		timeout_missed_cron:          rt.new_null()
		timeout_late_cron:            rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_theme(_args ...rt.PhpVal) &Class_WP_Theme {
	mut obj := &Class_WP_Theme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site_health_auto_updates(_args ...rt.PhpVal) &Class_WP_Site_Health_Auto_Updates {
	mut obj := &Class_WP_Site_Health_Auto_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site_Health) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'show_site_health_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.show_site_health_tab(dispatch_arg_0)
			return rt.new_null()
		}
		'get_instance' {
			return Class_WP_Site_Health.get_instance()
		}
		'enqueue_scripts' {
			this.enqueue_scripts()
			return rt.new_null()
		}
		'perform_test' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.perform_test(dispatch_arg_0)
		}
		'prepare_sql_data' {
			this.prepare_sql_data()
			return rt.new_null()
		}
		'check_wp_version_check_exists' {
			this.check_wp_version_check_exists()
			return rt.new_null()
		}
		'get_test_wordpress_version' {
			return this.get_test_wordpress_version()
		}
		'get_test_plugin_version' {
			return this.get_test_plugin_version()
		}
		'get_test_theme_version' {
			return this.get_test_theme_version()
		}
		'get_test_php_version' {
			return this.get_test_php_version()
		}
		'test_php_extension_availability' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.test_php_extension_availability(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'get_test_php_extensions' {
			return this.get_test_php_extensions()
		}
		'get_test_php_default_timezone' {
			return this.get_test_php_default_timezone()
		}
		'get_test_php_sessions' {
			return this.get_test_php_sessions()
		}
		'get_test_sql_server' {
			return this.get_test_sql_server()
		}
		'get_test_dotorg_communication' {
			return this.get_test_dotorg_communication()
		}
		'get_test_is_in_debug_mode' {
			return this.get_test_is_in_debug_mode()
		}
		'get_test_https_status' {
			return this.get_test_https_status()
		}
		'get_test_ssl_support' {
			return this.get_test_ssl_support()
		}
		'get_test_scheduled_events' {
			return this.get_test_scheduled_events()
		}
		'get_test_background_updates' {
			return this.get_test_background_updates()
		}
		'get_test_plugin_theme_auto_updates' {
			return this.get_test_plugin_theme_auto_updates()
		}
		'get_test_available_updates_disk_space' {
			return this.get_test_available_updates_disk_space()
		}
		'get_test_insecure_registration' {
			return this.get_test_insecure_registration()
		}
		'get_test_update_temp_backup_writable' {
			return this.get_test_update_temp_backup_writable()
		}
		'get_test_loopback_requests' {
			return this.get_test_loopback_requests()
		}
		'get_test_http_requests' {
			return this.get_test_http_requests()
		}
		'get_test_rest_availability' {
			return this.get_test_rest_availability()
		}
		'get_test_file_uploads' {
			return this.get_test_file_uploads()
		}
		'get_test_authorization_header' {
			return this.get_test_authorization_header()
		}
		'get_test_page_cache' {
			return this.get_test_page_cache()
		}
		'get_test_persistent_object_cache' {
			return this.get_test_persistent_object_cache()
		}
		'get_autoloaded_options_size' {
			return this.get_autoloaded_options_size()
		}
		'get_test_autoloaded_options' {
			return this.get_test_autoloaded_options()
		}
		'get_test_search_engine_visibility' {
			return this.get_test_search_engine_visibility()
		}
		'get_test_opcode_cache' {
			return this.get_test_opcode_cache()
		}
		'get_tests' {
			return Class_WP_Site_Health.get_tests()
		}
		'admin_body_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.admin_body_class(dispatch_arg_0)
		}
		'wp_schedule_test_init' {
			this.wp_schedule_test_init()
			return rt.new_null()
		}
		'get_cron_tasks' {
			this.get_cron_tasks()
			return rt.new_null()
		}
		'has_missed_cron' {
			return rt.new_bool(this.has_missed_cron())
		}
		'has_late_cron' {
			return rt.new_bool(this.has_late_cron())
		}
		'detect_plugin_theme_auto_update_issues' {
			return this.detect_plugin_theme_auto_update_issues()
		}
		'can_perform_loopback' {
			return this.can_perform_loopback()
		}
		'maybe_create_scheduled_event' {
			this.maybe_create_scheduled_event()
			return rt.new_null()
		}
		'wp_cron_scheduled_check' {
			this.wp_cron_scheduled_check()
			return rt.new_null()
		}
		'is_development_environment' {
			return this.is_development_environment()
		}
		'get_page_cache_headers' {
			return this.get_page_cache_headers()
		}
		'check_for_page_caching' {
			return this.check_for_page_caching()
		}
		'get_page_cache_detail' {
			return this.get_page_cache_detail()
		}
		'get_good_response_time_threshold' {
			return rt.new_int(this.get_good_response_time_threshold())
		}
		'should_suggest_persistent_object_cache' {
			return rt.new_bool(this.should_suggest_persistent_object_cache())
		}
		'available_object_cache_services' {
			return this.available_object_cache_services()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_acceptable_mysql_version' { return this.is_acceptable_mysql_version }
		'is_recommended_mysql_version' { return this.is_recommended_mysql_version }
		'is_mariadb' { return rt.new_bool(this.is_mariadb) }
		'mysql_server_version' { return this.mysql_server_version }
		'mysql_required_version' { return this.mysql_required_version }
		'mysql_recommended_version' { return this.mysql_recommended_version }
		'mariadb_recommended_version' { return this.mariadb_recommended_version }
		'php_memory_limit' { return this.php_memory_limit }
		'schedules' { return this.schedules }
		'crons' { return this.crons }
		'last_missed_cron' { return this.last_missed_cron }
		'last_late_cron' { return this.last_late_cron }
		'timeout_missed_cron' { return this.timeout_missed_cron }
		'timeout_late_cron' { return this.timeout_late_cron }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Site_Health) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_acceptable_mysql_version' {
			this.is_acceptable_mysql_version = val
			return true
		}
		'is_recommended_mysql_version' {
			this.is_recommended_mysql_version = val
			return true
		}
		'is_mariadb' {
			this.is_mariadb = val.to_bool()
			return true
		}
		'mysql_server_version' {
			this.mysql_server_version = val
			return true
		}
		'mysql_required_version' {
			this.mysql_required_version = val
			return true
		}
		'mysql_recommended_version' {
			this.mysql_recommended_version = val
			return true
		}
		'mariadb_recommended_version' {
			this.mariadb_recommended_version = val
			return true
		}
		'php_memory_limit' {
			this.php_memory_limit = val
			return true
		}
		'schedules' {
			this.schedules = val
			return true
		}
		'crons' {
			this.crons = val
			return true
		}
		'last_missed_cron' {
			this.last_missed_cron = val
			return true
		}
		'last_late_cron' {
			this.last_late_cron = val
			return true
		}
		'timeout_missed_cron' {
			this.timeout_missed_cron = val
			return true
		}
		'timeout_late_cron' {
			this.timeout_late_cron = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Theme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site_Health_Auto_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site_Health_Auto_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site_Health_Auto_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
