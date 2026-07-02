import rt

fn wp_version_check(var_extra_stats rt.PhpVal, force_check bool) {
	mut var_force_check := force_check
	mut var_wpdb := rt.new_null()
	mut var_wp_local_package := rt.new_null()
	mut var_php_version := rt.new_null()
	mut var_current := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_timeout := rt.new_null()
	mut var_time_not_changed := false
	mut var_locale := rt.new_null()
	mut var_mysql_version := rt.new_null()
	mut var_num_blogs := rt.new_null()
	mut var_wp_install := rt.new_null()
	mut var_multisite_enabled := i64(0)
	mut var_extensions := rt.new_null()
	mut var_query := rt.new_null()
	mut var_table_names := rt.new_null()
	mut var_myisam_tables := rt.new_null()
	mut var_all_unprefixed_tables := rt.new_null()
	mut var_unprefixed_myisam_tables := rt.new_null()
	mut var_gd_info := rt.new_null()
	mut var_post_body := rt.new_null()
	mut var_url := rt.new_null()
	mut var_http_url := rt.new_null()
	mut var_ssl := rt.new_null()
	mut var_doing_cron := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_response := rt.new_null()
	mut var_body := rt.new_null()
	mut var_offers := rt.new_null()
	mut var_offer := rt.new_null()
	mut var_value := rt.new_null()
	mut var_offer_key := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_ttl := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	var_php_version = rt.get_constant('PHP_VERSION')
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_core')])
	var_translations = rt.call_function('wp_get_installed_translations', [
		rt.new_string('core'),
	])
	if var_current.clone().is_object()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_get_wp_version', []rt.PhpVal{}), rt.get_property(var_current, 'version_checked'))))) {
		var_current = rt.new_bool(false)
	}
	if !(var_current.clone().is_object()) {
		var_current = create_stdclass()
		rt.set_property(var_current, 'updates', rt.new_array())
		rt.set_property(var_current, 'version_checked', rt.call_function('wp_get_wp_version',
			[]rt.PhpVal{}))
	}
	if !(!rt.is_true(var_extra_stats)) {
		var_force_check = true
	}
	var_timeout = rt.get_constant('MINUTE_IN_SECONDS')
	var_time_not_changed = !(rt.get_property(var_current, 'last_checked')).is_null()
		&& rt.is_true(rt.greater(var_timeout, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked'))))
	if !var_force_check && var_time_not_changed {
		return
	}
	var_locale = rt.call_function('apply_filters', [
		rt.new_string('core_version_check_locale'),
		rt.call_function('get_locale', []rt.PhpVal{}),
	])
	rt.set_property(var_current, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('set_site_transient', [rt.new_string('update_core'),
		var_current.clone()])
	if rt.is_true(rt.call_function('method_exists', [var_wpdb.clone(),
		rt.new_string('db_server_info')]))
	{
		var_mysql_version = rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('method_exists', [var_wpdb.clone(),
		rt.new_string('db_version')]))
	{
		var_mysql_version = rt.call_function('preg_replace', [
			rt.new_string('/[^0-9.].*/'),
			rt.new_string(''),
			rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{}),
		])
	} else {
		var_mysql_version = rt.new_string('N/A')
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_num_blogs = rt.call_function('get_blog_count', []rt.PhpVal{})
		var_wp_install = rt.call_function('network_site_url', []rt.PhpVal{})
		var_multisite_enabled = 1
	} else {
		var_multisite_enabled = 0
		var_num_blogs = rt.new_int(1)
		var_wp_install = rt.call_function('home_url', [rt.new_string('/')])
	}
	var_extensions = rt.call_function('get_loaded_extensions', []rt.PhpVal{})
	rt.call_function('sort', [var_extensions.clone(),
		rt.bitwise_or(rt.get_constant('SORT_STRING'), rt.get_constant('SORT_FLAG_CASE'))])
	var_query = rt.create_array([
		rt.ArrayItem{ key: 'version', val: rt.call_function('wp_get_wp_version', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'php', val: var_php_version },
		rt.ArrayItem{ key: 'locale', val: var_locale },
		rt.ArrayItem{ key: 'mysql', val: var_mysql_version },
		rt.ArrayItem{
			key: 'local_package'
			val: if !var_wp_local_package.is_null() {
				var_wp_local_package
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{ key: 'blogs', val: var_num_blogs },
		rt.ArrayItem{ key: 'users', val: rt.call_function('get_user_count', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'multisite_enabled', val: var_multisite_enabled },
		rt.ArrayItem{ key: 'initial_db_version', val: rt.call_function('get_site_option', [
			rt.new_string('initial_db_version'),
		]) },
		rt.ArrayItem{ key: 'myisam_tables', val: rt.new_array() },
		rt.ArrayItem{ key: 'extensions', val: rt.call_function('array_combine', [
			var_extensions.clone(),
			rt.call_function('array_map', [rt.new_string('phpversion'),
				var_extensions.clone()]),
		]) },
		rt.ArrayItem{ key: 'platform_flags', val: rt.create_array([
			rt.ArrayItem{ key: 'os', val: rt.get_constant('PHP_OS') },
			rt.ArrayItem{
				key: 'bits'
				val: if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
					32
				} else {
					64
				}
			},
		]) },
		rt.ArrayItem{ key: 'image_support', val: rt.new_array() },
	])
	var_table_names = rt.call_function('implode', [rt.new_string("','"),
		rt.call_method(var_wpdb, 'tables', []rt.PhpVal{})])
	var_myisam_tables = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = %s AND TABLE_NAME IN ('${var_table_names.to_string()}') AND ENGINE = %s;"),
			rt.get_constant('DB_NAME'),
			rt.new_string('MyISAM'),
		]),
		rt.get_constant('OBJECT_K'),
	])
	if !(!rt.is_true(var_myisam_tables)) {
		var_all_unprefixed_tables = rt.call_method(var_wpdb, 'tables', [
			rt.new_string('all'),
			rt.new_bool(false),
		])
		closure_1_fn := fn [var_all_unprefixed_tables] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_carry := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_prefixed_myisam_table := if args.len > 1 {
				args[1].clone()
			} else {
				rt.new_null()
			}
			mut iter_1 := var_all_unprefixed_tables.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_unprefixed := item_1.val
				if rt.is_true(rt.call_function('str_ends_with', [
					var_prefixed_myisam_table.clone(), var_unprefixed.clone()]))
				{
					var_carry.array_push(var_unprefixed.clone())
					break
				}
			}
			return
		}
		var_unprefixed_myisam_tables = rt.call_function('array_reduce', [
			rt.func_array_keys(var_myisam_tables.clone()),
			rt.new_closure(closure_1_fn),
			rt.new_array(),
		])
		var_query.array_set('myisam_tables', var_unprefixed_myisam_tables.clone())
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gd_info')])) {
		var_gd_info = rt.call_function('gd_info', []rt.PhpVal{})
		var_gd_info = rt.call_function('array_filter', [var_gd_info.clone()])
		var_query.array_get_mut('image_support').array_set('gd', rt.func_array_keys(rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{
					key: 'webp'
					val: rt.new_bool(var_gd_info.array_isset(rt.new_string('WebP Support')))
				},
				rt.ArrayItem{
					key: 'avif'
					val: rt.new_bool(var_gd_info.array_isset(rt.new_string('AVIF Support')))
				},
				rt.ArrayItem{
					key: 'heic'
					val: rt.new_bool(var_gd_info.array_isset(rt.new_string('HEIC Support')))
				},
				rt.ArrayItem{
					key: 'jxl'
					val: rt.new_bool(var_gd_info.array_isset(rt.new_string('JXL Support')))
				},
			]),
		])))
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Imagick')])) {
		mut iife_temp_1 := Class_Imagick{}
		mut iife_result_1 := iife_temp_1.queryformats(rt.new_string('WEBP'))
		mut iife_temp_2 := Class_Imagick{}
		mut iife_result_2 := iife_temp_2.queryformats(rt.new_string('AVIF'))
		mut iife_temp_3 := Class_Imagick{}
		mut iife_result_3 := iife_temp_3.queryformats(rt.new_string('HEIC'))
		mut iife_temp_4 := Class_Imagick{}
		mut iife_result_4 := iife_temp_4.queryformats(rt.new_string('JXL'))
		var_query.array_get_mut('image_support').array_set('imagick', rt.func_array_keys(rt.call_function('array_filter', [
			rt.create_array([
				rt.ArrayItem{ key: 'webp', val: !(!rt.is_true(iife_result_1)) },
				rt.ArrayItem{ key: 'avif', val: !(!rt.is_true(iife_result_2)) },
				rt.ArrayItem{ key: 'heic', val: !(!rt.is_true(iife_result_3)) },
				rt.ArrayItem{ key: 'jxl', val: !(!rt.is_true(iife_result_4)) },
			]),
		])))
	}
	var_query = rt.call_function('apply_filters', [
		rt.new_string('core_version_check_query_args'),
		var_query.clone(),
	])
	var_post_body = rt.create_array([
		rt.ArrayItem{ key: 'translations', val: rt.call_function('wp_json_encode', [
			var_translations.clone(),
		]) },
	])
	if rt.is_true(rt.new_bool(var_extra_stats.clone().is_array())) {
		var_post_body = rt.call_function('array_merge', [var_post_body.clone(),
			var_extra_stats.clone()])
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')]))
		&& rt.is_true(rt.call_function('in_array', [rt.get_constant('WP_AUTO_UPDATE_CORE'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'beta'
	}, rt.ArrayItem{ key: none, val: 'rc' }, rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{
		key: none
		val: 'branch-development'
	}]), rt.new_bool(true)])) {
		var_query.array_set('channel', rt.get_constant('WP_AUTO_UPDATE_CORE'))
	}
	var_url =
		rt.new_string('http://api.wordpress.org/core/version-check/1.7/?' +(rt.call_function('http_build_query', [var_query.clone(), rt.new_string(''), rt.new_string('&')])).str())
	var_http_url = var_url.clone()
	var_ssl = rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(),
			rt.new_string('https')])
	}
	var_doing_cron = rt.call_function('wp_doing_cron', []rt.PhpVal{})
	var_options = {
		'timeout':    if rt.is_true(var_doing_cron) { 30 } else { 3 }
		'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() +
			'; ' + (rt.call_function('home_url', [rt.new_string('/')])).str()
		'headers':    {
			'wp_install': var_wp_install
			'wp_blog':    rt.call_function('home_url', [rt.new_string('/')])
		}
		'body':       var_post_body
	}
	var_response = rt.call_function('wp_remote_post', [var_url.clone(),
		rt.create_array_from_native_map(var_options)])
	if rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
				' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
				|| rt.is_true(rt.get_constant('WP_DEBUG')) {
				rt.get_constant('E_USER_WARNING')
			} else {
				rt.get_constant('E_USER_NOTICE')
			}])
		var_response = rt.call_function('wp_remote_post', [var_http_url.clone(),
			rt.create_array_from_native_map(var_options)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_response.clone()]))))) {
		return
	}
	var_body = rt.new_string(rt.call_function('wp_remote_retrieve_body', [
		var_response.clone()]).to_string().trim_space())
	var_body = rt.call_function('json_decode', [var_body.clone(),
		rt.new_bool(true)])
	if !(var_body.clone().is_array()) || !(var_body.array_isset(rt.new_string('offers'))) {
		return
	}
	var_offers = var_body.array_get(rt.new_string('offers'))
	mut iter_2 := var_offers.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_offer_shadow := item_2.val
		mut iter_3 := var_offer_shadow.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_value_shadow := item_3.val
			mut var_offer_key_shadow := item_3.key
			if rt.is_true(rt.identical(rt.new_string('packages'), var_offer_key_shadow)) {
				var_offer_shadow.array_set('packages', rt.array_to_object(rt.call_function('array_intersect_key', [
					rt.call_function('array_map', [rt.new_string('esc_url'),
						var_offer_shadow.array_get(rt.new_string('packages'))]),
					rt.call_function('array_fill_keys', [
						rt.create_array([rt.ArrayItem{ key: none, val: 'full' },
							rt.ArrayItem{ key: none, val: 'no_content' },
							rt.ArrayItem{ key: none, val: 'new_bundled' },
							rt.ArrayItem{ key: none, val: 'partial' },
							rt.ArrayItem{ key: none, val: 'rollback' }]),
						rt.new_string(''),
					]),
				])))
			} else if rt.is_true(rt.identical(rt.new_string('download'), var_offer_key_shadow)) {
				var_offer_shadow.array_set('download', rt.call_function('esc_url', [
					var_value_shadow.clone(),
				]))
			} else {
				var_offer_shadow.array_set(var_offer_key_shadow, rt.call_function('esc_html', [
					var_value_shadow.clone(),
				]))
			}
		}
		var_offer_shadow = rt.array_to_object(rt.call_function('array_intersect_key', [
			var_offer_shadow.clone(),
			rt.call_function('array_fill_keys', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'response' },
					rt.ArrayItem{ key: none, val: 'download' },
					rt.ArrayItem{ key: none, val: 'locale' },
					rt.ArrayItem{ key: none, val: 'packages' },
					rt.ArrayItem{ key: none, val: 'current' },
					rt.ArrayItem{ key: none, val: 'version' },
					rt.ArrayItem{ key: none, val: 'php_version' },
					rt.ArrayItem{ key: none, val: 'mysql_version' },
					rt.ArrayItem{ key: none, val: 'new_bundled' },
					rt.ArrayItem{ key: none, val: 'partial_version' },
					rt.ArrayItem{ key: none, val: 'notify_email' },
					rt.ArrayItem{ key: none, val: 'support_email' },
					rt.ArrayItem{ key: none, val: 'new_files' }]),
				rt.new_string(''),
			]),
		]))
	}
	var_updates = create_stdclass()
	rt.set_property(var_updates, 'updates', var_offers.clone())
	rt.set_property(var_updates, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.set_property(var_updates, 'version_checked', rt.call_function('wp_get_wp_version',
		[]rt.PhpVal{}))
	if var_body.array_isset(rt.new_string('translations')) {
		rt.set_property(var_updates, 'translations',
			var_body.array_get(rt.new_string('translations')))
	}
	rt.call_function('set_site_transient', [rt.new_string('update_core'),
		var_updates.clone()])
	if !(!rt.is_true(var_body.array_get(rt.new_string('ttl')))) {
		var_ttl = rt.new_int((var_body.array_get(rt.new_string('ttl'))).to_i64())
		if rt.is_true(var_ttl)
			&& rt.is_true(rt.less(rt.add(rt.call_function('time', []rt.PhpVal{}), var_ttl), rt.call_function('wp_next_scheduled', [rt.new_string('wp_version_check')]))) {
			rt.call_function('wp_schedule_single_event', [
				rt.add(rt.call_function('time', []rt.PhpVal{}), var_ttl),
				rt.new_string('wp_version_check'),
			])
		}
	}
	if rt.is_true(var_doing_cron)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_maybe_auto_update')]))))) {
		rt.call_function('do_action', [rt.new_string('wp_maybe_auto_update')])
	}
}

fn wp_update_plugins(var_extra_stats rt.PhpVal) {
	mut var_plugins := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_active := rt.new_null()
	mut var_current := rt.new_null()
	mut var_doing_cron := rt.new_null()
	mut var_timeout := rt.new_null()
	mut var_time_not_changed := false
	mut var_plugin_changed := false
	mut var_p := map[string]rt.PhpVal{}
	mut var_file := rt.new_null()
	mut var_update_details := rt.new_null()
	mut var_plugin_file := rt.new_null()
	mut var_to_send := rt.new_null()
	mut var_locales := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_http_url := ''
	mut var_ssl := rt.new_null()
	mut var_raw_response := rt.new_null()
	mut var_updates := rt.new_null()
	mut var_response := rt.new_null()
	mut var_plugin_data := map[string]rt.PhpVal{}
	mut var_hostname := rt.new_null()
	mut var_update := rt.new_null()
	mut var_translation := map[string]rt.PhpVal{}
	mut var_sanitize_plugin_update_payload := rt.new_null()
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('get_plugins'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	var_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
	var_translations = rt.call_function('wp_get_installed_translations', [
		rt.new_string('plugins'),
	])
	var_active = rt.call_function('get_option', [rt.new_string('active_plugins'),
		rt.new_array()])
	var_current = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(var_current.clone().is_object()) {
		var_current = create_stdclass()
	}
	var_doing_cron = rt.call_function('wp_doing_cron', []rt.PhpVal{})
	mut switch_val_1 := rt.call_function('current_filter', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrader_process_complete'))) {
		var_timeout = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('load-update-core.php'))) {
		var_timeout = rt.get_constant('MINUTE_IN_SECONDS')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('load-plugins.php')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('load-update.php'))) {
		var_timeout = rt.get_constant('HOUR_IN_SECONDS')
	} else {
		if rt.is_true(var_doing_cron) {
			var_timeout = rt.mul(rt.new_int(2), rt.get_constant('HOUR_IN_SECONDS'))
		} else {
			var_timeout = rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))
		}
	}
	var_time_not_changed = !(rt.get_property(var_current, 'last_checked')).is_null()
		&& rt.is_true(rt.greater(var_timeout, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked'))))
	if var_time_not_changed && rt.is_true(rt.new_bool(!(rt.is_true(var_extra_stats)))) {
		var_plugin_changed = false
		mut iter_4 := var_plugins.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_p_shadow := item_4.val
			mut var_file_shadow := item_4.key
			if !(rt.get_property(var_current, 'checked').array_isset(var_file_shadow))
				|| rt.is_true(rt.new_bool((rt.get_property(var_current, 'checked').array_get(var_file_shadow)).str() != (var_p_shadow['Version']).str())) {
				var_plugin_changed = true
			}
		}
		if !(rt.get_property(var_current, 'response')).is_null()
			&& rt.get_property(var_current, 'response').is_array() {
			mut iter_5 := rt.get_property(var_current, 'response').iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_update_details_shadow := item_5.val
				mut var_plugin_file_shadow := item_5.key
				if !(var_plugins.array_isset(var_plugin_file_shadow)) {
					var_plugin_changed = true
					break
				}
			}
		}
		if !var_plugin_changed {
			return
		}
	}
	rt.set_property(var_current, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('set_site_transient', [rt.new_string('update_plugins'),
		var_current.clone()])
	var_to_send = rt.call_function('compact', [rt.new_string('plugins'),
		rt.new_string('active')])
	var_locales = rt.call_function('array_values', [
		rt.call_function('get_available_languages', []rt.PhpVal{}),
	])
	var_locales = rt.call_function('apply_filters', [
		rt.new_string('plugins_update_check_locales'),
		var_locales.clone(),
	])
	var_locales = rt.call_function('array_unique', [var_locales.clone()])
	if rt.is_true(var_doing_cron) {
		var_timeout = rt.new_int(30)
	} else {
		var_timeout = rt.new_int(3 + var_plugins.clone().array_count() / 10)
	}
	var_options = {
		'timeout':    var_timeout
		'body':       {
			'plugins':      rt.call_function('wp_json_encode', [
				var_to_send.clone()])
			'translations': rt.call_function('wp_json_encode', [
				var_translations.clone()])
			'locale':       rt.call_function('wp_json_encode', [
				var_locales.clone()])
			'all':          rt.call_function('wp_json_encode', [
				rt.new_bool(true)])
		}
		'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() +
			'; ' + (rt.call_function('home_url', [rt.new_string('/')])).str()
	}
	if rt.is_true(var_extra_stats) {
		var_options.array_get_mut('body').array_set('update_stats', rt.call_function('wp_json_encode', [
			var_extra_stats.clone(),
		]))
	}
	var_url = rt.new_string('http://api.wordpress.org/plugins/update-check/1.1/')
	var_http_url = var_url.str()
	var_ssl = rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(),
			rt.new_string('https')])
	}
	var_raw_response = rt.call_function('wp_remote_post', [var_url.clone(),
		rt.create_array_from_native_map(var_options)])
	if rt.is_true(var_ssl)
		&& rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()])) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
				' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
				|| rt.is_true(rt.get_constant('WP_DEBUG')) {
				rt.get_constant('E_USER_WARNING')
			} else {
				rt.get_constant('E_USER_NOTICE')
			}])
		var_raw_response = rt.call_function('wp_remote_post', [
			rt.new_string(var_http_url.str()).clone(), rt.create_array_from_native_map(var_options)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_raw_response.clone()]))))) {
		return
	}
	var_updates = create_stdclass()
	rt.set_property(var_updates, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.set_property(var_updates, 'response', rt.new_array())
	rt.set_property(var_updates, 'translations', rt.new_array())
	rt.set_property(var_updates, 'no_update', rt.new_array())
	mut iter_6 := var_plugins.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_p_shadow := item_6.val
		mut var_file_shadow := item_6.key
		rt.get_property(var_updates, 'checked').array_set(var_file_shadow, var_p_shadow['Version'])
	}
	var_response = rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_raw_response.clone()]),
		rt.new_bool(true),
	])
	if rt.is_true(var_response) && var_response.clone().is_array() {
		rt.set_property(var_updates, 'response', var_response.array_get(rt.new_string('plugins')))
		rt.set_property(var_updates, 'translations',
			var_response.array_get(rt.new_string('translations')))
		rt.set_property(var_updates, 'no_update',
			var_response.array_get(rt.new_string('no_update')))
	}
	mut iter_7 := var_plugins.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_plugin_data_shadow := item_7.val
		mut var_plugin_file_shadow := item_7.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_data_shadow['UpdateURI']))))
			|| rt.get_property(var_updates, 'response').array_isset(var_plugin_file_shadow) {
			continue
		}
		var_hostname = rt.call_function('wp_parse_url', [
			rt.call_function('sanitize_url', [var_plugin_data_shadow['UpdateURI']]),
			rt.get_constant('PHP_URL_HOST'),
		])
		var_update = rt.call_function('apply_filters', [
			rt.new_string('update_plugins_${var_hostname.to_string()}'),
			rt.new_bool(false),
			var_plugin_data_shadow.clone(),
			var_plugin_file_shadow.clone(),
			var_locales.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
			continue
		}
		var_update = rt.array_to_object(var_update)
		if !(!(rt.get_property(var_update, 'version')).is_null()) {
			continue
		}
		rt.set_property(var_update, 'id', var_plugin_data_shadow['UpdateURI'])
		rt.set_property(var_update, 'plugin', var_plugin_file_shadow.clone())
		if !(!(rt.get_property(var_update, 'new_version')).is_null()) {
			rt.set_property(var_update, 'new_version', rt.get_property(var_update, 'version'))
		}
		if !(!rt.is_true(rt.get_property(var_update, 'translations'))) {
			mut iter_8 := rt.get_property(var_update, 'translations').iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_translation_shadow := item_8.val
				if var_translation_shadow.array_isset(rt.new_string('language'))
					&& var_translation_shadow.array_isset(rt.new_string('package')) {
					var_translation_shadow['type'] = rt.new_string('plugin')
					var_translation_shadow['slug'] = if !(rt.get_property(var_update, 'slug')).is_null() {
						rt.get_property(var_update, 'slug')
					} else {
						rt.get_property(var_update, 'id')
					}
					rt.get_property(var_updates, 'translations').array_push(var_translation_shadow.clone())
				}
			}
		}
		rt.get_property(var_updates, 'no_update').array_unset(var_plugin_file_shadow)
		rt.get_property(var_updates, 'response').array_unset(var_plugin_file_shadow)
		if rt.is_true(rt.call_function('version_compare', [
			rt.get_property(var_update, 'new_version'),
			var_plugin_data_shadow['Version'],
			rt.new_string('>'),
		]))
		{
			rt.get_property(var_updates, 'response').array_set(var_plugin_file_shadow,
				var_update.clone())
		} else {
			rt.get_property(var_updates, 'no_update').array_set(var_plugin_file_shadow,
				var_update.clone())
		}
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_item := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		var_item = rt.array_to_object(var_item)
		rt.get_property(var_item, 'translations') = rt.new_null()
		rt.get_property(var_item, 'compatibility') = rt.new_null()
		return
	}
	var_sanitize_plugin_update_payload = rt.new_closure(closure_6_fn)
	rt.call_function('array_walk', [rt.get_property(var_updates, 'response'),
		var_sanitize_plugin_update_payload.clone()])
	rt.call_function('array_walk', [rt.get_property(var_updates, 'no_update'),
		var_sanitize_plugin_update_payload.clone()])
	rt.call_function('set_site_transient', [rt.new_string('update_plugins'),
		var_updates.clone()])
}

fn wp_update_themes(var_extra_stats rt.PhpVal) {
	mut var_installed_themes := rt.new_null()
	mut var_translations := rt.new_null()
	mut var_last_update := rt.new_null()
	mut var_themes := rt.new_null()
	mut var_checked := rt.new_null()
	mut var_request := map[string]rt.PhpVal{}
	mut var_theme := rt.new_null()
	mut var_doing_cron := rt.new_null()
	mut var_timeout := rt.new_null()
	mut var_time_not_changed := false
	mut var_theme_changed := false
	mut var_v := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_update_details := rt.new_null()
	mut var_locales := rt.new_null()
	mut var_options := map[string]rt.PhpVal{}
	mut var_url := rt.new_null()
	mut var_http_url := ''
	mut var_ssl := rt.new_null()
	mut var_raw_response := rt.new_null()
	mut var_new_update := rt.new_null()
	mut var_response := rt.new_null()
	mut var_theme_data := map[string]rt.PhpVal{}
	mut var_theme_stylesheet := rt.new_null()
	mut var_hostname := rt.new_null()
	mut var_update := rt.new_null()
	mut var_translation := map[string]rt.PhpVal{}
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return
	}
	var_installed_themes = rt.call_function('wp_get_themes', []rt.PhpVal{})
	var_translations = rt.call_function('wp_get_installed_translations', [
		rt.new_string('themes'),
	])
	var_last_update = rt.call_function('get_site_transient', [
		rt.new_string('update_themes'),
	])
	if !(var_last_update.clone().is_object()) {
		var_last_update = create_stdclass()
	}
	var_themes = rt.new_array()
	var_checked = rt.new_array()
	var_request = rt.new_array()
	var_request['active'] = rt.call_function('get_option', [rt.new_string('stylesheet')])
	mut iter_9 := var_installed_themes.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_theme_shadow := item_9.val
		var_checked.array_set(rt.call_method(var_theme_shadow, 'get_stylesheet', []rt.PhpVal{}), rt.call_method(var_theme_shadow,
			'get', [rt.new_string('Version')]))
		var_themes.array_set(rt.call_method(var_theme_shadow, 'get_stylesheet', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'Name', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('Name'),
			]) },
			rt.ArrayItem{ key: 'Title', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('Name'),
			]) },
			rt.ArrayItem{ key: 'Version', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('Version'),
			]) },
			rt.ArrayItem{ key: 'Author', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('Author'),
			]) },
			rt.ArrayItem{ key: 'Author URI', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('AuthorURI'),
			]) },
			rt.ArrayItem{ key: 'UpdateURI', val: rt.call_method(var_theme_shadow, 'get', [
				rt.new_string('UpdateURI'),
			]) },
			rt.ArrayItem{ key: 'Template', val: rt.call_method(var_theme_shadow, 'get_template',
				[]rt.PhpVal{}) },
			rt.ArrayItem{ key: 'Stylesheet', val: rt.call_method(var_theme_shadow,
				'get_stylesheet', []rt.PhpVal{}) },
		]))
	}
	var_doing_cron = rt.call_function('wp_doing_cron', []rt.PhpVal{})
	mut switch_val_2 := rt.call_function('current_filter', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('upgrader_process_complete'))) {
		var_timeout = rt.new_int(0)
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('load-update-core.php'))) {
		var_timeout = rt.get_constant('MINUTE_IN_SECONDS')
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('load-themes.php')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('load-update.php'))) {
		var_timeout = rt.get_constant('HOUR_IN_SECONDS')
	} else {
		if rt.is_true(var_doing_cron) {
			var_timeout = rt.mul(rt.new_int(2), rt.get_constant('HOUR_IN_SECONDS'))
		} else {
			var_timeout = rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))
		}
	}
	var_time_not_changed = !(rt.get_property(var_last_update, 'last_checked')).is_null()
		&& rt.is_true(rt.greater(var_timeout, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_last_update, 'last_checked'))))
	if var_time_not_changed && rt.is_true(rt.new_bool(!(rt.is_true(var_extra_stats)))) {
		var_theme_changed = false
		mut iter_10 := var_checked.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_v_shadow := item_10.val
			mut var_slug_shadow := item_10.key
			if !(rt.get_property(var_last_update, 'checked').array_isset(var_slug_shadow))
				|| rt.is_true(rt.new_bool((rt.get_property(var_last_update, 'checked').array_get(var_slug_shadow)).str() != var_v_shadow.str())) {
				var_theme_changed = true
			}
		}
		if !(rt.get_property(var_last_update, 'response')).is_null()
			&& rt.get_property(var_last_update, 'response').is_array() {
			mut iter_11 := rt.get_property(var_last_update, 'response').iterator()
			for {
				item_11 := iter_11.next() or { break }
				mut var_update_details_shadow := item_11.val
				mut var_slug_shadow := item_11.key
				if !(var_checked.array_isset(var_slug_shadow)) {
					var_theme_changed = true
					break
				}
			}
		}
		if !var_theme_changed {
			return
		}
	}
	rt.set_property(var_last_update, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('set_site_transient', [rt.new_string('update_themes'),
		var_last_update.clone()])
	var_request['themes'] = var_themes.clone()
	var_locales = rt.call_function('array_values', [
		rt.call_function('get_available_languages', []rt.PhpVal{}),
	])
	var_locales = rt.call_function('apply_filters', [
		rt.new_string('themes_update_check_locales'),
		var_locales.clone(),
	])
	var_locales = rt.call_function('array_unique', [var_locales.clone()])
	if rt.is_true(var_doing_cron) {
		var_timeout = rt.new_int(30)
	} else {
		var_timeout = rt.new_int(3 + var_themes.clone().array_count() / 10)
	}
	var_options = {
		'timeout':    var_timeout
		'body':       {
			'themes':       rt.call_function('wp_json_encode', [
				rt.create_array_from_native_map(var_request),
			])
			'translations': rt.call_function('wp_json_encode', [
				var_translations.clone()])
			'locale':       rt.call_function('wp_json_encode', [
				var_locales.clone()])
		}
		'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() +
			'; ' + (rt.call_function('home_url', [rt.new_string('/')])).str()
	}
	if rt.is_true(var_extra_stats) {
		var_options.array_get_mut('body').array_set('update_stats', rt.call_function('wp_json_encode', [
			var_extra_stats.clone(),
		]))
	}
	var_url = rt.new_string('http://api.wordpress.org/themes/update-check/1.1/')
	var_http_url = var_url.str()
	var_ssl = rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.clone(),
			rt.new_string('https')])
	}
	var_raw_response = rt.call_function('wp_remote_post', [var_url.clone(),
		rt.create_array_from_native_map(var_options)])
	if rt.is_true(var_ssl)
		&& rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()])) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.new_string(
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() +
				' ' +(rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str()),
			if rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))
				|| rt.is_true(rt.get_constant('WP_DEBUG')) {
				rt.get_constant('E_USER_WARNING')
			} else {
				rt.get_constant('E_USER_NOTICE')
			}])
		var_raw_response = rt.call_function('wp_remote_post', [
			rt.new_string(var_http_url.str()).clone(), rt.create_array_from_native_map(var_options)])
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_raw_response.clone()]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(200), rt.call_function('wp_remote_retrieve_response_code', [var_raw_response.clone()]))))) {
		return
	}
	var_new_update = create_stdclass()
	rt.set_property(var_new_update, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.set_property(var_new_update, 'checked', var_checked.clone())
	var_response = rt.call_function('json_decode', [
		rt.call_function('wp_remote_retrieve_body', [var_raw_response.clone()]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(var_response.clone().is_array())) {
		rt.set_property(var_new_update, 'response', var_response.array_get(rt.new_string('themes')))
		rt.set_property(var_new_update, 'no_update',
			var_response.array_get(rt.new_string('no_update')))
		rt.set_property(var_new_update, 'translations',
			var_response.array_get(rt.new_string('translations')))
	}
	mut iter_12 := var_themes.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_theme_data_shadow := item_12.val
		mut var_theme_stylesheet_shadow := item_12.key
		if rt.is_true(rt.new_bool(!(rt.is_true(var_theme_data_shadow['UpdateURI']))))
			|| rt.get_property(var_new_update, 'response').array_isset(var_theme_stylesheet_shadow) {
			continue
		}
		var_hostname = rt.call_function('wp_parse_url', [
			rt.call_function('sanitize_url', [var_theme_data_shadow['UpdateURI']]),
			rt.get_constant('PHP_URL_HOST'),
		])
		var_update = rt.call_function('apply_filters', [
			rt.new_string('update_themes_${var_hostname.to_string()}'),
			rt.new_bool(false),
			var_theme_data_shadow.clone(),
			var_theme_stylesheet_shadow.clone(),
			var_locales.clone(),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
			continue
		}
		var_update = rt.array_to_object(var_update)
		if !(!(rt.get_property(var_update, 'version')).is_null()) {
			continue
		}
		rt.set_property(var_update, 'id', var_theme_data_shadow['UpdateURI'])
		if !(!(rt.get_property(var_update, 'new_version')).is_null()) {
			rt.set_property(var_update, 'new_version', rt.get_property(var_update, 'version'))
		}
		if !(!rt.is_true(rt.get_property(var_update, 'translations'))) {
			mut iter_13 := rt.get_property(var_update, 'translations').iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_translation_shadow := item_13.val
				if var_translation_shadow.array_isset(rt.new_string('language'))
					&& var_translation_shadow.array_isset(rt.new_string('package')) {
					var_translation_shadow['type'] = rt.new_string('theme')
					var_translation_shadow['slug'] = if !(rt.get_property(var_update, 'theme')).is_null() {
						rt.get_property(var_update, 'theme')
					} else {
						rt.get_property(var_update, 'id')
					}
					rt.get_property(var_new_update, 'translations').array_push(var_translation_shadow.clone())
				}
			}
		}
		rt.get_property(var_new_update, 'no_update').array_unset(var_theme_stylesheet_shadow)
		rt.get_property(var_new_update, 'response').array_unset(var_theme_stylesheet_shadow)
		if rt.is_true(rt.call_function('version_compare', [
			rt.get_property(var_update, 'new_version'),
			var_theme_data_shadow['Version'],
			rt.new_string('>'),
		]))
		{
			rt.get_property(var_new_update, 'response').array_set(var_theme_stylesheet_shadow,
				rt.cast_array(var_update))
		} else {
			rt.get_property(var_new_update, 'no_update').array_set(var_theme_stylesheet_shadow,
				rt.cast_array(var_update))
		}
	}
	rt.call_function('set_site_transient', [rt.new_string('update_themes'), var_new_update])
}

fn wp_maybe_auto_update() {
	mut var_upgrader := rt.new_null()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php',
		'4')
	var_upgrader = create_wp_automatic_updater()
	var_upgrader.run()
}

fn wp_get_translation_updates() rt.PhpVal {
	mut var_updates := rt.new_null()
	mut var_transients := map[string]rt.PhpVal{}
	mut var_type := rt.new_null()
	mut var_transient := rt.new_null()
	mut var_translation := map[string]rt.PhpVal{}
	var_updates = rt.new_array()
	var_transients = {
		'update_core':    'core'
		'update_plugins': 'plugin'
		'update_themes':  'theme'
	}
	for var_transient_shadow, var_type_shadow in var_transients {
		var_transient_shadow = (rt.call_function('get_site_transient', [
			rt.new_string(var_transient_shadow.str()).clone()])).str()
		if !rt.is_true(rt.get_property(rt.new_string(var_transient_shadow.str()), 'translations')) {
			continue
		}
		mut iter_14 :=
			rt.get_property(rt.new_string(var_transient_shadow.str()), 'translations').iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_translation_shadow := item_14.val
			var_updates.array_push(rt.array_to_object(var_translation_shadow))
		}
	}
	return var_updates.clone()
}

fn wp_get_update_data() rt.PhpVal {
	mut var_counts := map[string]rt.PhpVal{}
	mut var_plugins := rt.new_null()
	mut var_update_plugins := rt.new_null()
	mut var_themes := rt.new_null()
	mut var_update_themes := rt.new_null()
	mut var_core := rt.new_null()
	mut var_update_wordpress := rt.new_null()
	mut var_titles := map[string]rt.PhpVal{}
	mut var_update_title := rt.new_null()
	mut var_update_data := map[string]rt.PhpVal{}
	var_counts = {
		'plugins':      rt.new_int(0)
		'themes':       rt.new_int(0)
		'wordpress':    rt.new_int(0)
		'translations': rt.new_int(0)
	}
	var_plugins = rt.call_function('current_user_can', [rt.new_string('update_plugins')])
	if rt.is_true(var_plugins) {
		var_update_plugins = rt.call_function('get_site_transient', [
			rt.new_string('update_plugins'),
		])
		if !(!rt.is_true(rt.get_property(var_update_plugins, 'response'))) {
			var_counts['plugins'] =
				rt.new_int(rt.get_property(var_update_plugins, 'response').array_count())
		}
	}
	var_themes = rt.call_function('current_user_can', [rt.new_string('update_themes')])
	if rt.is_true(var_themes) {
		var_update_themes = rt.call_function('get_site_transient', [
			rt.new_string('update_themes'),
		])
		if !(!rt.is_true(rt.get_property(var_update_themes, 'response'))) {
			var_counts['themes'] =
				rt.new_int(rt.get_property(var_update_themes, 'response').array_count())
		}
	}
	var_core = rt.call_function('current_user_can', [rt.new_string('update_core')])
	if rt.is_true(var_core)
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('get_core_updates')])) {
		var_update_wordpress = rt.call_function('get_core_updates', [
			rt.create_array([rt.ArrayItem{ key: 'dismissed', val: false }]),
		])
		if !(!rt.is_true(var_update_wordpress))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_update_wordpress.array_get(rt.new_int(0)), 'response'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'development'
		}, rt.ArrayItem{ key: none, val: 'latest' }]), rt.new_bool(true)])))))
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_core')])) {
			var_counts['wordpress'] = rt.new_int(1)
		}
	}
	if rt.is_true(var_core) || rt.is_true(var_plugins) || rt.is_true(var_themes)
		&& rt.is_true(wp_get_translation_updates()) {
		var_counts['translations'] = rt.new_int(1)
	}
	var_counts['total'] = rt.add(rt.add(rt.add(var_counts['plugins'], var_counts['themes']),
		var_counts['wordpress']), var_counts['translations'])
	var_titles = rt.new_array()
	if rt.is_true(var_counts['wordpress']) {
		var_titles['wordpress'] = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%d WordPress Update')]),
			var_counts['wordpress'],
		])
	}
	if rt.is_true(var_counts['plugins']) {
		var_titles['plugins'] = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d Plugin Update'),
				rt.new_string('%d Plugin Updates'), var_counts['plugins']]),
			var_counts['plugins'],
		])
	}
	if rt.is_true(var_counts['themes']) {
		var_titles['themes'] = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%d Theme Update'),
				rt.new_string('%d Theme Updates'), var_counts['themes']]),
			var_counts['themes'],
		])
	}
	if rt.is_true(var_counts['translations']) {
		var_titles['translations'] = rt.call_function('__', [
			rt.new_string('Translation Updates'),
		])
	}
	var_update_title = if rt.is_true(var_titles) { rt.call_function('esc_attr', [
			rt.call_function('implode', [rt.new_string(', '),
				rt.create_array_from_native_map(var_titles)]),
		]) } else { rt.new_string('') }
	var_update_data = {
		'counts': var_counts
		'title':  var_update_title
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_get_update_data'),
		rt.create_array_from_native_map(var_update_data), rt.create_array_from_native_map(var_titles)])
}

fn _maybe_update_core() {
	mut var_current := rt.new_null()
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_core')])
	if !(rt.get_property(var_current, 'last_checked')).is_null()
		&& !(rt.get_property(var_current, 'version_checked')).is_null()
		&& rt.is_true(rt.greater(rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked'))))
		&& rt.is_true(rt.identical(rt.call_function('wp_get_wp_version', []rt.PhpVal{}), rt.get_property(var_current, 'version_checked'))) {
		return
	}
	wp_version_check(rt.new_null(), false)
}

fn _maybe_update_plugins() {
	mut var_current := rt.new_null()
	var_current = rt.call_function('get_site_transient', [
		rt.new_string('update_plugins'),
	])
	if !(rt.get_property(var_current, 'last_checked')).is_null()
		&& rt.is_true(rt.greater(rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked')))) {
		return
	}
	wp_update_plugins(rt.new_null())
}

fn _maybe_update_themes() {
	mut var_current := rt.new_null()
	var_current = rt.call_function('get_site_transient', [rt.new_string('update_themes')])
	if !(rt.get_property(var_current, 'last_checked')).is_null()
		&& rt.is_true(rt.greater(rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS')), rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked')))) {
		return
	}
	wp_update_themes(rt.new_null())
}

fn wp_schedule_update_checks() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_version_check')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('twicedaily'), rt.new_string('wp_version_check')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_update_plugins')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('twicedaily'), rt.new_string('wp_update_plugins')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('wp_update_themes')])))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{}))))) {
		rt.call_function('wp_schedule_event', [rt.call_function('time', []rt.PhpVal{}),
			rt.new_string('twicedaily'), rt.new_string('wp_update_themes')])
	}
}

fn wp_clean_update_cache() {
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_clean_plugins_cache'),
	]))
	{
		rt.call_function('wp_clean_plugins_cache', []rt.PhpVal{})
	} else {
		rt.call_function('delete_site_transient', [rt.new_string('update_plugins')])
	}
	rt.call_function('wp_clean_themes_cache', []rt.PhpVal{})
	rt.call_function('delete_site_transient', [rt.new_string('update_core')])
}

fn wp_delete_all_temp_backups() {
	if rt.is_true(rt.call_function('get_option', [rt.new_string('core_updater.lock')]))
		|| rt.is_true(rt.call_function('get_option', [rt.new_string('auto_updater.lock')]))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		rt.call_function('wp_schedule_single_event', [
			rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS')),
			rt.new_string('wp_delete_temp_updater_backups'),
		])
		return
	}
	rt.call_function('add_action', [rt.new_string('shutdown'),
		rt.new_string('_wp_delete_all_temp_backups')])
}

fn _wp_delete_all_temp_backups() {
	mut var_wp_filesystem := rt.new_null()
	mut var_credentials := rt.new_null()
	mut var_temp_backup_dir := rt.new_null()
	mut var_dirlist := rt.new_null()
	mut var_dir := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('WP_Filesystem'),
	])))))
	{
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	var_credentials = rt.call_function('request_filesystem_credentials', [
		rt.new_string(''),
	])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_credentials))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('WP_Filesystem', [var_credentials.clone()]))))) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.call_function('__', [rt.new_string('Could not access filesystem.')])])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_filesystem, 'wp_content_dir',
		[]rt.PhpVal{})))))
	{
		rt.call_function('wp_trigger_error', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Unable to locate WordPress content directory (%s).'),
				]),
				rt.new_string('wp-content'),
			])])
		return
	}
	var_temp_backup_dir = rt.new_string(
		(rt.call_method(var_wp_filesystem, 'wp_content_dir', []rt.PhpVal{})).str() +
		'upgrade-temp-backup/')
	var_dirlist = rt.call_method(var_wp_filesystem, 'dirlist', [
		var_temp_backup_dir.clone()])
	var_dirlist = if rt.is_true(var_dirlist) { var_dirlist } else { rt.new_array() }
	mut iter_15 := rt.func_array_keys(var_dirlist.clone()).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_dir_shadow := item_15.val
		if rt.is_true(rt.identical(rt.new_string('.'), var_dir_shadow))
			|| rt.is_true(rt.identical(rt.new_string('..'), var_dir_shadow)) {
			continue
		}
		rt.call_method(var_wp_filesystem, 'delete', [
			rt.new_string(var_temp_backup_dir.str() + var_dir_shadow.str()),
			rt.new_bool(true),
		])
	}
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

struct Class_WP_Automatic_Updater {
	rt.PhpObjectBase
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_imagick(_args ...rt.PhpVal) &Class_Imagick {
	mut obj := &Class_Imagick{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_automatic_updater(_args ...rt.PhpVal) &Class_WP_Automatic_Updater {
	mut obj := &Class_WP_Automatic_Updater{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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

fn (mut this Class_Imagick) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Imagick) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Imagick) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Automatic_Updater) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Automatic_Updater) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	if (rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_site', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{}))))))
		|| rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})) {
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_maybe_update_core')])
	rt.call_function('add_action', [rt.new_string('wp_version_check'),
		rt.new_string('wp_version_check')])
	rt.call_function('add_action', [rt.new_string('load-plugins.php'),
		rt.new_string('wp_update_plugins')])
	rt.call_function('add_action', [rt.new_string('load-update.php'),
		rt.new_string('wp_update_plugins')])
	rt.call_function('add_action', [rt.new_string('load-update-core.php'),
		rt.new_string('wp_update_plugins')])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_maybe_update_plugins')])
	rt.call_function('add_action', [rt.new_string('wp_update_plugins'),
		rt.new_string('wp_update_plugins')])
	rt.call_function('add_action', [rt.new_string('load-themes.php'),
		rt.new_string('wp_update_themes')])
	rt.call_function('add_action', [rt.new_string('load-update.php'),
		rt.new_string('wp_update_themes')])
	rt.call_function('add_action', [rt.new_string('load-update-core.php'),
		rt.new_string('wp_update_themes')])
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_string('_maybe_update_themes')])
	rt.call_function('add_action', [rt.new_string('wp_update_themes'),
		rt.new_string('wp_update_themes')])
	rt.call_function('add_action', [rt.new_string('update_option_WPLANG'),
		rt.new_string('wp_clean_update_cache'), rt.new_int(10),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('wp_maybe_auto_update'),
		rt.new_string('wp_maybe_auto_update')])
	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('wp_schedule_update_checks')])
	rt.call_function('add_action', [rt.new_string('wp_delete_temp_updater_backups'),
		rt.new_string('wp_delete_all_temp_backups')])
}
