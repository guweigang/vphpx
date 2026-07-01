import rt

struct Class_WP_Site_Health {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
		is_acceptable_mysql_version rt.PhpVal = rt.new_null()
		is_recommended_mysql_version rt.PhpVal = rt.new_null()
		is_mariadb bool
		mysql_server_version rt.PhpVal = rt.new_string('')
		mysql_required_version rt.PhpVal = rt.new_string('5.5')
		mysql_recommended_version rt.PhpVal = rt.new_string('8.0')
		mariadb_recommended_version rt.PhpVal = rt.new_string('10.6')
		php_memory_limit rt.PhpVal = rt.new_null()
		schedules rt.PhpVal = rt.new_null()
		crons rt.PhpVal = rt.new_null()
		last_missed_cron rt.PhpVal = rt.new_null()
		last_late_cron rt.PhpVal = rt.new_null()
		timeout_missed_cron rt.PhpVal = rt.new_null()
		timeout_late_cron rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Site_Health) construct()  {
	this.maybe_create_scheduled_event()
	this.php_memory_limit = rt.call_function('ini_get', [rt.new_string('memory_limit')])
	this.timeout_late_cron = rt.new_int(0)
	this.timeout_missed_cron = rt.mul(// unsupported expression: Expr_UnaryMinus, rt.get_constant('MINUTE_IN_SECONDS'))
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')])) && rt.is_true(rt.get_constant('DISABLE_WP_CRON')))) {
		this.timeout_late_cron = rt.mul(// unsupported expression: Expr_UnaryMinus, rt.get_constant('MINUTE_IN_SECONDS'))
		this.timeout_missed_cron = rt.mul(// unsupported expression: Expr_UnaryMinus, rt.get_constant('HOUR_IN_SECONDS'))
	}
	rt.call_function('add_filter', [rt.new_string('admin_body_class'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_body_class' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_scripts' }])])
	rt.call_function('add_action', [rt.new_string('wp_site_health_scheduled_check'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wp_cron_scheduled_check' }])])
	rt.call_function('add_action', [rt.new_string('site_health_tab_content'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'show_site_health_tab' }])])
}

fn (mut this Class_WP_Site_Health) show_site_health_tab(var_tab rt.PhpVal)  {
	if rt.is_true(rt.identical(rt.new_string('debug'), var_tab)) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/site-health-info.php', '4')
	}
}

fn Class_WP_Site_Health.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_WP_Site_Health) enqueue_scripts()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_health_check_js_variables := { 'screen': rt.get_property(var_screen, 'id'), 'nonce': { 'site_status': rt.call_function('wp_create_nonce', [rt.new_string('health-check-site-status')]), 'site_status_result': rt.call_function('wp_create_nonce', [rt.new_string('health-check-site-status-result')]) }, 'site_status': { 'direct': map[string]rt.PhpVal{}, 'async': map[string]rt.PhpVal{}, 'issues': { 'good': rt.new_int(0), 'recommended': rt.new_int(0), 'critical': rt.new_int(0) } } }
	mut var_issue_counts := rt.call_function('get_transient', [rt.new_string('health-check-site-status-result')])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_issue_counts = rt.call_function('json_decode', [var_issue_counts.dup()])
		var_health_check_js_variables.array_get_mut('site_status').array_set('issues', var_issue_counts.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('site-health'), rt.get_property(var_screen, 'id'))) && !(rt.get_superglobal('_GET').array_isset(rt.new_string('tab'))) || !rt.is_true(rt.get_superglobal('_GET').array_get('tab')))) {
		mut var_tests := Class_WP_Site_Health.get_tests()
		if rt.is_true(this.is_development_environment()) {
			var_tests.array_get('async').array_unset(rt.new_string('https_status'))
		}
		{
			mut iter_1 := var_tests.array_get('direct').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_test := item_1.val
				if rt.is_true(rt.new_bool(var_test.array_get('test').is_string())) {
					mut var_test_function := rt.call_function('sprintf', [rt.new_string('get_test_%s'), var_test.array_get('test')])
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [rt.new_object('WP_Site_Health', []string{}, &this), var_test_function.dup()])) && rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_test_function }])])))) {
						var_health_check_js_variables.array_get_mut('site_status').array_get_mut('direct').array_push(this.perform_test(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Site_Health', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_test_function }])))
						continue
					}
				}
				if rt.is_true(rt.call_function('is_callable', [var_test.array_get('test')])) {
					var_health_check_js_variables.array_get_mut('site_status').array_get_mut('direct').array_push(this.perform_test(var_test.array_get('test')))
				}
			}
		}
		{
			mut iter_1 := var_tests.array_get('async').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_test := item_1.val
				if rt.is_true(rt.new_bool(var_test.array_get('test').is_string())) {
					var_health_check_js_variables.array_get_mut('site_status').array_get_mut('async').array_push(rt.create_array([rt.ArrayItem{ key: 'test', val: var_test.array_get('test') }, rt.ArrayItem{ key: 'has_rest', val: if !(var_test.array_get('has_rest')).is_null() { var_test.array_get('has_rest') } else { rt.new_bool(false) } }, rt.ArrayItem{ key: 'completed', val: false }, rt.ArrayItem{ key: 'headers', val: if !(var_test.array_get('headers')).is_null() { var_test.array_get('headers') } else { map[string]rt.PhpVal{} } }]))
				}
			}
		}
	}
	rt.call_function('wp_localize_script', [rt.new_string('site-health'), rt.new_string('SiteHealth'), var_health_check_js_variables.dup()])
}

fn (mut this Class_WP_Site_Health) perform_test(var_callback rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('site_status_test_result'), rt.call_function('call_user_func', [var_callback.dup()])])
}

fn (mut this Class_WP_Site_Health) prepare_sql_data()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_mysql_server_type := rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
	this.mysql_server_version = rt.call_method(var_wpdb, 'get_var', [rt.new_string('SELECT VERSION()')])
	if rt.is_true(rt.call_function('stristr', [var_mysql_server_type.dup(), rt.new_string('mariadb')])) {
		this.is_mariadb = true
		this.mysql_recommended_version = this.mariadb_recommended_version
	}
	this.is_acceptable_mysql_version = rt.call_function('version_compare', [this.mysql_required_version, this.mysql_server_version, rt.new_string('<=')])
	this.is_recommended_mysql_version = rt.call_function('version_compare', [this.mysql_recommended_version, this.mysql_server_version, rt.new_string('<=')])
}

fn (mut this Class_WP_Site_Health) check_wp_version_check_exists()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')]))))))) || !(rt.get_superglobal('_GET').array_isset(rt.new_string('health-check-test-wp_version_check'))))) {
		return rt.new_null()
	}
	print(if rt.is_true(rt.call_function('has_filter', [rt.new_string('wp_version_check'), rt.new_string('wp_version_check')])) { 'yes' } else { 'no' })
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WP_Site_Health) get_test_wordpress_version() rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'label', val: '' }, rt.ArrayItem{ key: 'status', val: '' }, rt.ArrayItem{ key: 'badge', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Performance')]) }, rt.ArrayItem{ key: 'color', val: 'blue' }]) }, rt.ArrayItem{ key: 'description', val: '' }, rt.ArrayItem{ key: 'actions', val: '' }, rt.ArrayItem{ key: 'test', val: 'wordpress_version' }])
	mut var_core_current_version := rt.call_function('wp_get_wp_version', []rt.PhpVal{})
	mut var_core_updates := rt.call_function('get_core_updates', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_core_updates.dup().is_array()))))) {
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress version %s')]), var_core_current_version.dup()]))
		var_result.array_set('description', rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('Unable to check if any new versions of WordPress are available.')])]))
		var_result.array_set('actions', rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('update-core.php?force-check=1')])]), rt.call_function('__', [rt.new_string('Check for updates manually')])]))
	} else {
		{
			mut iter_1 := var_core_updates.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_update := item_1.val
				mut var_core := item_1.key
				if rt.is_true(rt.identical(rt.new_string('upgrade'), rt.get_property(var_update, 'response'))) {
					mut var_current_version := rt.call_function('explode', [rt.new_string('.'), var_core_current_version.dup()])
					mut var_new_version := rt.call_function('explode', [rt.new_string('.'), rt.get_property(var_update, 'version')])
					mut var_current_major := rt.new_string((var_current_version.array_get(0)).str() + '.' + (var_current_version.array_get(1)).str())
					mut var_new_major := rt.new_string((var_new_version.array_get(0)).str() + '.' + (var_new_version.array_get(1)).str())
					var_result.array_set('label', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('WordPress update available (%s)')]), rt.get_property(var_update, 'version')]))
					var_result.array_set('actions', rt.call_function('sprintf', [rt.new_string('<a href="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('update-core.php')])]), rt.call_function('__', [rt.new_string('Install the latest version of WordPress')])]))
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_result.array_set('status', 'recommended')
						var_result.array_set('description', rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('A new version of WordPress is available.')])]))
					} else {
						var_result.array_set('status', 'critical')
						var_result.array_get_mut('badge').array_set('label', rt.call_function('__', [rt.new_string('Security')]))
						var_result.array_set('description', rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('A new minor update is available for your site. Because minor updates often address security, it&#8217;s important to install them.')])]))
					}
				} else {
					var_result.array_set('status', 'good')
					var_result.array_set('label', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Your version of WordPress (%s) is up to date')]), var_core_current_version.dup()]))
					var_result.array_set('description', rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('You are currently running the latest version of WordPress available, keep it up!')])]))
				}
			}
		}
	}
	return var_result.dup()
}

fn (mut this Class_WP_Site_Health) get_test_plugin_version() rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Your plugins are all up to date')]) }, rt.ArrayItem{ key: 'status', val: 'good' }, rt.ArrayItem{ key: 'badge', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Security')]) }, rt.ArrayItem{ key: 'color', val: 'blue' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('Plugins extend your site&#8217;s functionality with things like contact forms, ecommerce and much more. That means they have deep access to your site, so it&#8217;s vital to keep them up to date.')])]) }, rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [rt.new_string('<p><a href="%s">%s</a></p>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('plugins.php')])]), rt.call_function('__', [rt.new_string('Manage your plugins')])]) }, rt.ArrayItem{ key: 'test', val: 'plugin_version' }])
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_plugin_updates := rt.call_function('get_plugin_updates', []rt.PhpVal{})
	mut var_plugins_active := rt.new_int(rt.new_int(0))
	mut var_plugins_total := rt.new_int(rt.new_int(0))
	mut var_plugins_need_update := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			mut var_plugin_path := item_1.key
			rt.pre_inc(var_plugins_total)
			if rt.is_true(rt.call_function('is_plugin_active', [var_plugin_path.dup()])) {
				rt.pre_inc(var_plugins_active)
			}
			if rt.is_true(rt.new_bool(var_plugin_updates.dup().array_isset(var_plugin_path.dup()))) {
				rt.pre_inc(var_plugins_need_update)
			}
		}
	}
	if rt.is_true(rt.greater(var_plugins_need_update, rt.new_int(0))) {
		var_result.array_set('status', 'critical')
		var_result.array_set('label', rt.call_function('__', [rt.new_string('You have plugins waiting to be updated')]))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		if rt.is_true(rt.identical(rt.new_int(1), var_plugins_active)) {
			// unsupported expression: Expr_AssignOp_Concat
		} else if rt.is_true(rt.greater(var_plugins_active, rt.new_int(0))) {
			// unsupported expression: Expr_AssignOp_Concat
		} else {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_plugins_total, var_plugins_active)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))))) {
		mut var_unused_plugins := rt.sub(var_plugins_total, var_plugins_active)
		var_result.array_set('status', 'recommended')
		var_result.array_set('label', rt.call_function('__', [rt.new_string('You should remove inactive plugins')]))
		// unsupported expression: Expr_AssignOp_Concat
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_result.dup()
}

fn (mut this Class_WP_Site_Health) get_test_theme_version() rt.PhpVal {
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Your themes are all up to date')]) }, rt.ArrayItem{ key: 'status', val: 'good' }, rt.ArrayItem{ key: 'badge', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Security')]) }, rt.ArrayItem{ key: 'color', val: 'blue' }]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.new_string('<p>%s</p>'), rt.call_function('__', [rt.new_string('Themes add your site&#8217;s look and feel. It&#8217;s important to keep them up to date, to stay consistent with your brand and keep your site secure.')])]) }, rt.ArrayItem{ key: 'actions', val: rt.call_function('sprintf', [rt.new_string('<p><a href="%s">%s</a></p>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('themes.php')])]), rt.call_function('__', [rt.new_string('Manage your themes')])]) }, rt.ArrayItem{ key: 'test', val: 'theme_version' }])
	mut var_theme_updates := rt.call_function('get_theme_updates', []rt.PhpVal{})
	mut var_themes_total := rt.new_int(rt.new_int(0))
	mut var_themes_need_updates := rt.new_int(rt.new_int(0))
	mut var_themes_inactive := rt.new_int(rt.new_int(0))
	mut var_allowed_theme_count := rt.new_int(rt.new_int(1))
	mut var_has_default_theme := rt.new_bool(rt.new_bool(false))
	mut var_has_unused_themes := rt.new_bool(rt.new_bool(false))
	mut var_show_unused_themes := rt.new_bool(rt.new_bool(true))
	mut var_using_default_theme := rt.new_bool(rt.new_bool(false))
	mut var_all_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
	mut var_active_theme := 
	
}

fn (mut this Class_WP_Site_Health) get_test_php_version() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) test_php_extension_availability(var_extension_name rt.PhpVal, var_function_name rt.PhpVal, var_constant_name rt.PhpVal, var_class_name rt.PhpVal) bool {
	mut var_extension_name_mutated := var_extension_name
	mut var_function_name_mutated := var_function_name
	mut var_constant_name_mutated := var_constant_name
	mut var_class_name_mutated := var_class_name
}

fn (mut this Class_WP_Site_Health) get_test_php_extensions() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_php_default_timezone() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_php_sessions() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_sql_server() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_dotorg_communication() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_is_in_debug_mode() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_https_status() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_ssl_support() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_scheduled_events() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_background_updates() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_plugin_theme_auto_updates() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_available_updates_disk_space() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_insecure_registration() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_update_temp_backup_writable() rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
}

fn (mut this Class_WP_Site_Health) get_test_loopback_requests() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_http_requests() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_rest_availability() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_file_uploads() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_authorization_header() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_page_cache() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_persistent_object_cache() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_autoloaded_options_size() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_autoloaded_options() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_search_engine_visibility() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_test_opcode_cache() rt.PhpVal {
}

fn Class_WP_Site_Health.get_tests() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) admin_body_class(var_body_class rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) wp_schedule_test_init()  {
}

fn (mut this Class_WP_Site_Health) get_cron_tasks()  {
}

fn (mut this Class_WP_Site_Health) has_missed_cron() bool {
}

fn (mut this Class_WP_Site_Health) has_late_cron() bool {
}

fn (mut this Class_WP_Site_Health) detect_plugin_theme_auto_update_issues() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) can_perform_loopback() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) maybe_create_scheduled_event()  {
}

fn (mut this Class_WP_Site_Health) wp_cron_scheduled_check()  {
}

fn (mut this Class_WP_Site_Health) is_development_environment() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_page_cache_headers() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) check_for_page_caching() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_page_cache_detail() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) get_good_response_time_threshold() rt.PhpVal {
}

fn (mut this Class_WP_Site_Health) should_suggest_persistent_object_cache() bool {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WP_Site_Health) available_object_cache_services() rt.PhpVal {
}

fn create_wp_site_health() &Class_WP_Site_Health {
	mut obj := &Class_WP_Site_Health{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		is_acceptable_mysql_version: rt.new_null()
		is_recommended_mysql_version: rt.new_null()
		is_mariadb: false
		mysql_server_version: rt.new_string('')
		mysql_required_version: rt.new_string('5.5')
		mysql_recommended_version: rt.new_string('8.0')
		mariadb_recommended_version: rt.new_string('10.6')
		php_memory_limit: rt.new_null()
		schedules: rt.new_null()
		crons: rt.new_null()
		last_missed_cron: rt.new_null()
		last_late_cron: rt.new_null()
		timeout_missed_cron: rt.new_null()
		timeout_late_cron: rt.new_null()
	}
	obj.construct()
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
			return rt.new_bool(this.test_php_extension_availability(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
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
			return this.get_good_response_time_threshold()
		}
		'should_suggest_persistent_object_cache' {
			return rt.new_bool(this.should_suggest_persistent_object_cache())
		}
		'available_object_cache_services' {
			return this.available_object_cache_services()
		}
		else { return none }
	}
}

fn (this &Class_WP_Site_Health) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
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
		'instance' { this.instance = val; return true }
		'is_acceptable_mysql_version' { this.is_acceptable_mysql_version = val; return true }
		'is_recommended_mysql_version' { this.is_recommended_mysql_version = val; return true }
		'is_mariadb' { this.is_mariadb = (val).to_bool(); return true }
		'mysql_server_version' { this.mysql_server_version = val; return true }
		'mysql_required_version' { this.mysql_required_version = val; return true }
		'mysql_recommended_version' { this.mysql_recommended_version = val; return true }
		'mariadb_recommended_version' { this.mariadb_recommended_version = val; return true }
		'php_memory_limit' { this.php_memory_limit = val; return true }
		'schedules' { this.schedules = val; return true }
		'crons' { this.crons = val; return true }
		'last_missed_cron' { this.last_missed_cron = val; return true }
		'last_late_cron' { this.last_late_cron = val; return true }
		'timeout_missed_cron' { this.timeout_missed_cron = val; return true }
		'timeout_late_cron' { this.timeout_late_cron = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_admin_includes_class_wp_site_health_php() {
}
