import rt

fn wp_version_check(var_extra_stats rt.PhpVal, force_check bool) {
	mut var_wpdb := rt.new_null()
	mut var_wp_local_package := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return rt.new_null()
	}
	mut var_php_version := rt.get_constant('PHP_VERSION')
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_core')])
	mut var_translations := rt.call_function('wp_get_installed_translations', [rt.new_string('core')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_current.dup().is_object())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_current = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_current.dup().is_object()))))) {
		var_current = create_stdclass()
		rt.set_property(var_current, 'updates', rt.new_array())
		rt.set_property(var_current, 'version_checked', rt.call_function('wp_get_wp_version', []rt.PhpVal{}))
	}
	if !(!rt.is_true(var_extra_stats)) {
		force_check = true
	}
	mut var_timeout := rt.get_constant('MINUTE_IN_SECONDS')
	mut var_time_not_changed := !(rt.get_property(var_current, 'last_checked')).is_null() && rt.is_true(rt.greater(var_timeout, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked'))))
	if !(var_force_check) && var_time_not_changed {
		return rt.new_null()
	}
	mut var_locale := rt.call_function('apply_filters', [rt.new_string('core_version_check_locale'), rt.call_function('get_locale', []rt.PhpVal{})])
	rt.set_property(var_current, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.call_function('set_site_transient', [rt.new_string('update_core'), var_current.dup()])
	if rt.is_true(rt.call_function('method_exists', [var_wpdb.dup(), rt.new_string('db_server_info')])) {
		mut var_mysql_version := rt.call_method(var_wpdb, 'db_server_info', []rt.PhpVal{})
	} else if rt.is_true(rt.call_function('method_exists', [var_wpdb.dup(), rt.new_string('db_version')])) {
		var_mysql_version = rt.call_function('preg_replace', [rt.new_string('/[^0-9.].*/'), rt.new_string(''), rt.call_method(var_wpdb, 'db_version', []rt.PhpVal{})])
	} else {
		var_mysql_version = rt.new_string(rt.new_string('N/A'))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		mut var_num_blogs := rt.call_function('get_blog_count', []rt.PhpVal{})
		mut var_wp_install := rt.call_function('network_site_url', []rt.PhpVal{})
		mut var_multisite_enabled := 1
	} else {
		var_multisite_enabled = 0
		var_num_blogs = rt.new_int(rt.new_int(1))
		var_wp_install = rt.call_function('home_url', [rt.new_string('/')])
	}
	mut var_extensions := rt.call_function('get_loaded_extensions', []rt.PhpVal{})
	rt.call_function('sort', [var_extensions.dup(), rt.bitwise_or(rt.get_constant('SORT_STRING'), rt.get_constant('SORT_FLAG_CASE'))])
	mut var_query := rt.create_array([rt.ArrayItem{ key: 'version', val: rt.call_function('wp_get_wp_version', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'php', val: var_php_version }, rt.ArrayItem{ key: 'locale', val: var_locale }, rt.ArrayItem{ key: 'mysql', val: var_mysql_version }, rt.ArrayItem{ key: 'local_package', val: if !(var_wp_local_package).is_null() { var_wp_local_package } else { rt.new_string('') } }, rt.ArrayItem{ key: 'blogs', val: var_num_blogs }, rt.ArrayItem{ key: 'users', val: rt.call_function('get_user_count', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'multisite_enabled', val: var_multisite_enabled }, rt.ArrayItem{ key: 'initial_db_version', val: rt.call_function('get_site_option', [rt.new_string('initial_db_version')]) }, rt.ArrayItem{ key: 'myisam_tables', val: rt.new_array() }, rt.ArrayItem{ key: 'extensions', val: rt.call_function('array_combine', [var_extensions.dup(), rt.call_function('array_map', [rt.new_string('phpversion'), var_extensions.dup()])]) }, rt.ArrayItem{ key: 'platform_flags', val: rt.create_array([rt.ArrayItem{ key: 'os', val: rt.get_constant('PHP_OS') }, rt.ArrayItem{ key: 'bits', val: if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) { 32 } else { 64 } }]) }, rt.ArrayItem{ key: 'image_support', val: rt.new_array() }])
	mut var_table_names := rt.call_function('implode', [rt.new_string('\',\''), rt.call_method(var_wpdb, 'tables', []rt.PhpVal{})])
	mut var_myisam_tables := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.new_string("SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = %s AND TABLE_NAME IN ('${var_table_names.to_string()}') AND ENGINE = %s;"), rt.get_constant('DB_NAME'), rt.new_string('MyISAM')]), rt.get_constant('OBJECT_K')])
	if !(!rt.is_true(var_myisam_tables)) {
		mut var_all_unprefixed_tables := rt.call_method(var_wpdb, 'tables', [rt.new_string('all'), rt.new_bool(false)])
		closure_1_fn := fn [var_all_unprefixed_tables] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_carry := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_prefixed_myisam_table := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	{
		mut iter_1 := var_all_unprefixed_tables.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_unprefixed := item_1.val
			if rt.is_true(rt.call_function('str_ends_with', [var_prefixed_myisam_table.dup(), var_unprefixed.dup()])) {
				var_carry.array_push(var_unprefixed.dup())
				break
			}
		}
	}
	return var_carry.dup()
	}
		mut var_unprefixed_myisam_tables := rt.call_function('array_reduce', [rt.func_array_keys(var_myisam_tables.dup()), rt.new_closure(closure_1_fn), rt.new_array()])
		var_query.array_set('myisam_tables', var_unprefixed_myisam_tables.dup())
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gd_info')])) {
		mut var_gd_info := rt.call_function('gd_info', []rt.PhpVal{})
		var_gd_info = rt.call_function('array_filter', [var_gd_info.dup()])
		var_query.array_get_mut('image_support').array_set('gd', rt.func_array_keys(rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'webp', val: rt.new_bool(var_gd_info.array_isset(rt.new_string('WebP Support'))) }, rt.ArrayItem{ key: 'avif', val: rt.new_bool(var_gd_info.array_isset(rt.new_string('AVIF Support'))) }, rt.ArrayItem{ key: 'heic', val: rt.new_bool(var_gd_info.array_isset(rt.new_string('HEIC Support'))) }, rt.ArrayItem{ key: 'jxl', val: rt.new_bool(var_gd_info.array_isset(rt.new_string('JXL Support'))) }])])))
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('Imagick')])) {
		var_query.array_get_mut('image_support').array_set('imagick', rt.func_array_keys(rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: 'webp', val: !(!rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.queryformats(arg_0) }(rt.new_string('WEBP')))) }, rt.ArrayItem{ key: 'avif', val: !(!rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.queryformats(arg_0) }(rt.new_string('AVIF')))) }, rt.ArrayItem{ key: 'heic', val: !(!rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.queryformats(arg_0) }(rt.new_string('HEIC')))) }, rt.ArrayItem{ key: 'jxl', val: !(!rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Imagick{}; return temp.queryformats(arg_0) }(rt.new_string('JXL')))) }])])))
	}
	var_query = rt.call_function('apply_filters', [rt.new_string('core_version_check_query_args'), var_query.dup()])
	mut var_post_body := rt.create_array([rt.ArrayItem{ key: 'translations', val: rt.call_function('wp_json_encode', [var_translations.dup()]) }])
	if rt.is_true(rt.new_bool(var_extra_stats.dup().is_array())) {
		var_post_body = rt.call_function('array_merge', [var_post_body.dup(), var_extra_stats.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_AUTO_UPDATE_CORE')])) && rt.is_true(rt.call_function('in_array', [rt.get_constant('WP_AUTO_UPDATE_CORE'), rt.create_array([rt.ArrayItem{ key: none, val: 'beta' }, rt.ArrayItem{ key: none, val: 'rc' }, rt.ArrayItem{ key: none, val: 'development' }, rt.ArrayItem{ key: none, val: 'branch-development' }]), rt.new_bool(true)])))) {
		var_query.array_set('channel', rt.get_constant('WP_AUTO_UPDATE_CORE'))
	}
	mut var_url := rt.new_string('http://api.wordpress.org/core/version-check/1.7/?' + (rt.call_function('http_build_query', [var_query.dup(), rt.new_string(''), rt.new_string('&')])).str())
	mut var_http_url := var_url.dup()
	mut var_ssl := rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])
	if rt.is_true(var_ssl) {
		var_url = rt.call_function('set_url_scheme', [var_url.dup(), rt.new_string('https')])
	}
	mut var_doing_cron := rt.call_function('wp_doing_cron', []rt.PhpVal{})
	mut var_options := { 'timeout': if rt.is_true(var_doing_cron) { rt.new_int(30) } else { rt.new_int(3) }, 'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str(), 'headers': { 'wp_install': var_wp_install, 'wp_blog': rt.call_function('home_url', [rt.new_string('/')]) }, 'body': var_post_body }
	mut var_response := rt.call_function('wp_remote_post', [var_url.dup(), var_options.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])))) {
		rt.call_function('wp_trigger_error', [rt.new_string(@FN), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + ' ' + (rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str(), if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) || rt.is_true(rt.get_constant('WP_DEBUG')))) { rt.get_constant('E_USER_WARNING') } else { rt.get_constant('E_USER_NOTICE') }])
		var_response = rt.call_function('wp_remote_post', [var_http_url.dup(), var_options.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_body := rt.new_string(rt.new_string(rt.call_function('wp_remote_retrieve_body', [var_response.dup()]).to_string().trim_space()))
	var_body = rt.call_function('json_decode', [var_body.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_body.dup().is_array()))))) || !(var_body.array_isset(rt.new_string('offers'))))) {
		return rt.new_null()
	}
	mut var_offers := var_body.array_get('offers')
	{
		mut iter_1 := var_offers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_offer := item_1.val
			{
				mut iter_2 := var_offer.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_value := item_2.val
					mut var_offer_key := item_2.key
					if rt.is_true(rt.identical(rt.new_string('packages'), var_offer_key)) {
						var_offer.array_set('packages', // unsupported expression: Expr_Cast_Object)
					} else if rt.is_true(rt.identical(rt.new_string('download'), var_offer_key)) {
						var_offer.array_set('download', rt.call_function('esc_url', [var_value.dup()]))
					} else {
						var_offer.array_set(var_offer_key, rt.call_function('esc_html', [var_value.dup()]))
					}
				}
			}
			var_offer = // unsupported expression: Expr_Cast_Object
		}
	}
	mut var_updates := create_stdclass()
	rt.set_property(var_updates, 'updates', var_offers.dup())
	rt.set_property(var_updates, 'last_checked', rt.call_function('time', []rt.PhpVal{}))
	rt.set_property(var_updates, 'version_checked', rt.call_function('wp_get_wp_version', []rt.PhpVal{}))
	if var_body.array_isset(rt.new_string('translations')) {
		rt.set_property(var_updates, 'translations', var_body.array_get('translations'))
	}
	rt.call_function('set_site_transient', [rt.new_string('update_core'), var_updates.dup()])
	if !(!rt.is_true(var_body.array_get('ttl'))) {
		mut var_ttl := // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.new_bool(rt.is_true(var_ttl) && rt.is_true(rt.less(rt.add(rt.call_function('time', []rt.PhpVal{}), var_ttl), rt.call_function('wp_next_scheduled', [rt.new_string('wp_version_check')]))))) {
			rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), var_ttl), rt.new_string('wp_version_check')])
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_doing_cron) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('doing_action', [rt.new_string('wp_maybe_auto_update')]))))))) {
		rt.call_function('do_action', [rt.new_string('wp_maybe_auto_update')])
	}
}

fn wp_update_plugins(var_extra_stats rt.PhpVal) {
	if rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('get_plugins')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	}
	mut var_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_translations := rt.call_function('wp_get_installed_translations', [rt.new_string('plugins')])
	mut var_active := rt.call_function('get_option', [rt.new_string('active_plugins'), rt.new_array()])
	mut var_current := rt.call_function('get_site_transient', [rt.new_string('update_plugins')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_current.dup().is_object()))))) {
		var_current = create_stdclass()
	}
	mut var_doing_cron := rt.call_function('wp_doing_cron', []rt.PhpVal{})
	mut switch_val_1 := rt.call_function('current_filter', []rt.PhpVal{})
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('upgrader_process_complete'))) {
		mut var_timeout := rt.new_int(rt.new_int(0))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('load-update-core.php'))) {
		var_timeout = rt.get_constant('MINUTE_IN_SECONDS')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('load-plugins.php'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('load-update.php'))) {
		var_timeout = rt.get_constant('HOUR_IN_SECONDS')
	} else {
		if rt.is_true(var_doing_cron) {
			var_timeout = rt.mul(rt.new_int(2), rt.get_constant('HOUR_IN_SECONDS'))
		} else {
			var_timeout = rt.mul(rt.new_int(12), rt.get_constant('HOUR_IN_SECONDS'))
		}
	}
	mut var_time_not_changed := !(rt.get_property(var_current, 'last_checked')).is_null() && rt.is_true(rt.greater(var_timeout, rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_property(var_current, 'last_checked'))))
	if rt.is_true(rt.new_bool(var_time_not_changed && rt.is_true(rt.new_bool(!(rt.is_true(var_extra_stats)))))) {
		mut var_plugin_changed := false
		{
			mut iter_1 := var_plugins.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_p := item_1.val
				mut var_file := item_1.key
				if rt.is_true(rt.new_bool(!(rt.get_property(var_current, 'checked').array_isset(var_file)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
					var_plugin_changed = true
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.get_property(var_current, 'response')).is_null() && rt.is_true(rt.new_bool(rt.get_property(, 'response').is_array())))) {
			{
				mut iter_1 := rt.get_property(var_current, 'response').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_update_details := item_1.val
					mut var_plugin_file := item_1.key
					if !(var_plugins.array_isset(var_plugin_file)) {
						
					}
				}
			}
		}
		if !(var_plugin_changed) {
			return rt.new_null()
		}
	}
	rt.set_property(, 'last_checked', )
	
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_Imagick {
	rt.PhpObjectBase
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_imagick() &Class_Imagick {
	mut obj := &Class_Imagick{
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




pub fn init_wp_includes_update_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
