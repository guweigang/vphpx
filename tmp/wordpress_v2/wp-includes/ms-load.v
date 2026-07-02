import rt

fn is_subdomain_install() bool {
	if rt.is_true(rt.call_function('defined', [rt.new_string('SUBDOMAIN_INSTALL')])) {
		return (rt.get_constant('SUBDOMAIN_INSTALL')).to_bool()
	}
	return rt.is_true(rt.call_function('defined', [rt.new_string('VHOST')]))
		&& rt.is_true(rt.identical(rt.new_string('yes'), rt.get_constant('VHOST')))
}

fn wp_get_active_network_plugins() rt.PhpVal {
	mut var_active_plugins := rt.new_null()
	mut var_plugins := []rt.PhpVal{}
	mut var_plugin := rt.new_null()
	var_active_plugins = rt.cast_array(rt.call_function('get_site_option', [
		rt.new_string('active_sitewide_plugins'),
		rt.new_array(),
	]))
	if !rt.is_true(var_active_plugins) {
		return rt.new_array()
	}
	var_plugins = rt.new_array()
	var_active_plugins = rt.func_array_keys(var_active_plugins.clone())
	rt.call_function('sort', [var_active_plugins.clone()])
	mut iter_1 := var_active_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin_shadow := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_file', [var_plugin_shadow.clone()])))))
			&& rt.is_true(rt.call_function('str_ends_with', [var_plugin_shadow.clone(), rt.new_string('.php')]))
			&& rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_shadow.str())])) {
			var_plugins << (rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + var_plugin_shadow.str()
		}
	}
	return var_plugins.clone()
}

fn ms_site_check() rt.PhpVal {
	mut var_check := rt.new_null()
	mut var_blog := rt.new_null()
	mut var_admin_email := rt.new_null()
	var_check = rt.call_function('apply_filters', [rt.new_string('ms_site_check'),
		rt.new_null()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return rt.new_bool(true)
	}
	if rt.is_true(rt.call_function('is_super_admin', []rt.PhpVal{})) {
		return rt.new_bool(true)
	}
	var_blog = rt.call_function('get_site', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'deleted'))) {
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-deleted.php'),
		]))
		{
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-deleted.php')
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('This site is no longer available.'),
				]),
				rt.new_string(''),
				rt.create_array([
					rt.ArrayItem{ key: 'response', val: 410 },
				]),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('2'), rt.get_property(var_blog, 'deleted'))) {
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-inactive.php'),
		]))
		{
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-inactive.php')
		} else {
			var_admin_email = rt.call_function('str_replace', [
				rt.new_string('@'), rt.new_string(' AT '),
				rt.call_function('get_site_option', [
					rt.new_string('admin_email'),
					rt.new_string('support@' +(rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'domain')).str()),
				])])
			rt.call_function('wp_die', [
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('This site has not been activated yet. If you are having problems activating your site, please contact %s.'),
					]),
					rt.call_function('sprintf', [
						rt.new_string('<a href="mailto:%1$s">%1$s</a>'),
						var_admin_email.clone(),
					]),
				]),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'archived')))
		|| rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_blog, 'spam'))) {
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-suspended.php'),
		]))
		{
			return rt.new_string((rt.get_constant('WP_CONTENT_DIR')).str() + '/blog-suspended.php')
		} else {
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('This site has been archived or suspended.'),
				]),
				rt.new_string(''),
				rt.create_array([
					rt.ArrayItem{ key: 'response', val: 410 },
				]),
			])
		}
	}
	return rt.new_bool(true)
}

fn get_network_by_path(var_domain rt.PhpVal, var_path rt.PhpVal, var_segments rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_WP_Network{}
	mut iife_result_0 := iife_temp_0.get_by_path(var_domain.clone(), var_path.clone(),
		var_segments.clone())
	return iife_result_0
}

fn get_site_by_path(var_domain rt.PhpVal, var_path rt.PhpVal, var_segments_arg rt.PhpVal) bool {
	mut var_segments := var_segments_arg
	mut var_path_segments := rt.new_null()
	mut var_paths := []rt.PhpVal{}
	mut var_pre := rt.new_null()
	mut var_domains := []rt.PhpVal{}
	mut var_args := map[string]rt.PhpVal{}
	mut var_result := rt.new_null()
	mut var_site := rt.new_null()
	var_path_segments = rt.call_function('array_filter', [
		rt.call_function('explode', [rt.new_string('/'),
			rt.new_string(var_path.clone().to_string().trim_space())]),
	])
	var_segments = rt.call_function('apply_filters', [
		rt.new_string('site_by_path_segments_count'),
		var_segments.clone(),
		var_domain.clone(),
		var_path.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_segments))))
		&& rt.is_true(rt.greater(rt.new_int(var_path_segments.clone().array_count()), var_segments)) {
		var_path_segments = rt.call_function('array_slice', [
			var_path_segments.clone(), rt.new_int(0), var_segments.clone()])
	}
	var_paths = rt.new_array()
	for rt.is_true(rt.new_int(var_path_segments.clone().array_count())) {
		var_paths << '/' +
			(rt.call_function('implode', [rt.new_string('/'), var_path_segments.clone()])).str() +
			'/'
		rt.call_function('array_pop', [var_path_segments.clone()])
	}
	var_paths << '/'
	var_pre = rt.call_function('apply_filters', [rt.new_string('pre_get_site_by_path'),
		rt.new_null(), var_domain.clone(), var_path.clone(), var_segments.clone(),
		rt.create_array_from_list(var_paths)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pre))))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_pre, 'WP_Site')))))) {
			var_pre = create_wp_site(var_pre.clone())
		}
		return var_pre.to_bool()
	}
	var_domains = [var_domain]
	if rt.is_true(rt.call_function('str_starts_with', [var_domain.clone(),
		rt.new_string('www.')]))
	{
		var_domains << rt.call_function('substr', [var_domain.clone(),
			rt.new_int(4)])
	}
	var_args = {
		'number':                 rt.new_int(1)
		'update_site_meta_cache': rt.new_bool(false)
	}
	if var_domains.len > 1 {
		var_args['domain__in'] = var_domains.clone()
		var_args.array_get_mut('orderby').array_set('domain_length', 'DESC')
	} else {
		var_args['domain'] = rt.call_function('array_shift', [
			rt.create_array_from_list(var_domains),
		])
	}
	if var_paths.len > 1 {
		var_args['path__in'] = var_paths.clone()
		var_args.array_get_mut('orderby').array_set('path_length', 'DESC')
	} else {
		var_args['path'] = rt.call_function('array_shift', [
			rt.create_array_from_list(var_paths),
		])
	}
	var_result = rt.call_function('get_sites', [
		rt.create_array_from_native_map(var_args),
	])
	var_site = rt.call_function('array_shift', [var_result.clone()])
	if rt.is_true(var_site) {
		return var_site.to_bool()
	}
	return false
}

fn ms_load_current_site_and_network(var_domain rt.PhpVal, var_path_arg rt.PhpVal, subdomain bool) bool {
	mut var_subdomain := subdomain
	mut var_path := var_path_arg
	mut var_current_site := rt.new_null()
	mut var_current_blog := rt.new_null()
	mut var_networks := rt.new_null()
	mut var_blog_id := i64(0)
	mut var_scheme := ''
	mut var_destination := rt.new_null()
	if rt.is_true(rt.call_function('defined', [rt.new_string('DOMAIN_CURRENT_SITE')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('PATH_CURRENT_SITE')])) {
		var_current_site = create_stdclass()
		rt.set_property(var_current_site, 'id', if rt.is_true(rt.call_function('defined', [
			rt.new_string('SITE_ID_CURRENT_SITE'),
		]))
		{ rt.get_constant('SITE_ID_CURRENT_SITE') } else { rt.new_int(1) })
		rt.set_property(var_current_site, 'domain', rt.get_constant('DOMAIN_CURRENT_SITE'))
		rt.set_property(var_current_site, 'path', rt.get_constant('PATH_CURRENT_SITE'))
		if rt.is_true(rt.call_function('defined', [rt.new_string('BLOG_ID_CURRENT_SITE')])) {
			rt.set_property(var_current_site, 'blog_id', rt.get_constant('BLOG_ID_CURRENT_SITE'))
		} else if rt.is_true(rt.call_function('defined', [
			rt.new_string('BLOGID_CURRENT_SITE'),
		]))
		{
			rt.set_property(var_current_site, 'blog_id', rt.get_constant('BLOGID_CURRENT_SITE'))
		}
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'domain'), var_domain.clone()])))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'path'), var_path.clone()]))) {
			var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(),
				rt.new_null()))
		} else if
			rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('/'), rt.get_property(var_current_site, 'path')))))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.get_property(var_current_site, 'domain'), var_domain.clone()])))
			&& rt.is_true(rt.identical(rt.new_int(0), rt.call_function('stripos', [var_path.clone(), rt.get_property(var_current_site, 'path')]))) {
			var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(), rt.new_int(
				1 +
				rt.call_function('explode', [rt.new_string('/'), rt.new_string(rt.get_property(var_current_site, 'path').to_string().trim_space())]).array_count())))
		} else {
			var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(),
				rt.new_int(1)))
		}
	} else if !var_subdomain {
		var_current_site = rt.call_function('wp_cache_get', [
			rt.new_string('current_network'),
			rt.new_string('site-options'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_current_site)))) {
			var_networks = rt.call_function('get_networks', [
				rt.create_array([rt.ArrayItem{ key: 'number', val: 2 }]),
			])
			if var_networks.clone().array_count() == 1 {
				var_current_site = rt.call_function('array_shift', [
					var_networks.clone()])
				rt.call_function('wp_cache_add', [rt.new_string('current_network'),
					var_current_site.clone(), rt.new_string('site-options')])
			} else if !rt.is_true(var_networks) {
				return false
			}
		}
		if !rt.is_true(var_current_site) {
			mut iife_temp_1 := Class_WP_Network{}
			mut iife_result_1 := iife_temp_1.get_by_path(var_domain.clone(), var_path.clone(),
				rt.new_int(1))
			var_current_site = iife_result_1
		}
		if !rt.is_true(var_current_site) {
			rt.call_function('do_action', [rt.new_string('ms_network_not_found'),
				var_domain.clone(), var_path.clone()])
			return false
		} else if rt.is_true(rt.identical(var_path, rt.get_property(var_current_site, 'path'))) {
			var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(),
				rt.new_null()))
		} else {
			var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(), rt.call_function('substr_count', [
				rt.get_property(var_current_site, 'path'),
				rt.new_string('/'),
			])))
		}
	} else {
		var_current_blog = rt.new_bool(get_site_by_path(var_domain.clone(), var_path.clone(),
			rt.new_int(1)))
		if rt.is_true(var_current_blog) {
			mut iife_temp_2 := Class_WP_Network{}
			mut iife_result_2 := iife_temp_2.get_instance(if rt.is_true(rt.get_property(var_current_blog,
				'site_id'))
			{
				rt.get_property(var_current_blog, 'site_id')
			} else {
				rt.new_int(1)
			})
			var_current_site = iife_result_2
		} else {
			mut iife_temp_3 := Class_WP_Network{}
			mut iife_result_3 := iife_temp_3.get_by_path(var_domain.clone(), var_path.clone(),
				rt.new_int(1))
			var_current_site = iife_result_3
		}
	}
	if rt.is_true(var_current_blog)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_current_blog, 'site_id')).to_i64()), rt.get_property(var_current_site, 'id'))))) {
		mut iife_temp_4 := Class_WP_Network{}
		mut iife_result_4 := iife_temp_4.get_instance(rt.get_property(var_current_blog, 'site_id'))
		var_current_site = iife_result_4
	}
	if !rt.is_true(var_current_site) {
		rt.call_function('do_action', [rt.new_string('ms_network_not_found'),
			var_domain.clone(), var_path.clone()])
		return false
	}
	if !rt.is_true(var_current_blog) && rt.is_true(rt.call_function('wp_installing', []rt.PhpVal{})) {
		var_current_blog = create_stdclass()
		rt.set_property(var_current_blog, 'blog_id', rt.new_int(1))
		var_blog_id = 1
		rt.set_property(var_current_blog, 'public', rt.new_int(1))
	}
	if !rt.is_true(var_current_blog) {
		var_scheme = if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) {
			'https'
		} else {
			'http'
		}
		var_destination = rt.new_string((rt.concat(rt.concat(rt.concat(rt.new_string(var_scheme.str()),
			rt.new_string('://')), rt.get_property(var_current_site, 'domain')), rt.get_property(var_current_site,
			'path'))).str())
		rt.call_function('do_action', [rt.new_string('ms_site_not_found'),
			var_current_site.clone(), var_domain.clone(), var_path.clone()])
		if var_subdomain
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('NOBLOGREDIRECT')]))))) {
			var_path = rt.new_string('wp-signup.php?new=' +
				(rt.call_function('str_replace', [rt.new_string('.' +(rt.get_property(var_current_site, 'domain')).str()), rt.new_string(''), var_domain.clone()])).str())
			var_destination = rt.call_function('apply_filters', [
				rt.new_string('network_site_url'),
				rt.new_string(var_destination.str() + var_path.str()),
				var_path.clone(),
				rt.new_string(var_scheme.str()).clone(),
			])
		} else if var_subdomain {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('%siteurl%'),
				rt.get_constant('NOBLOGREDIRECT')))))
			{
				var_destination = rt.get_constant('NOBLOGREDIRECT')
			}
		} else if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [
			rt.get_property(var_current_site, 'domain'),
			var_domain.clone(),
		])))
		{
			return false
		}
		return var_destination.to_bool()
	}
	if !rt.is_true(rt.get_property(var_current_site, 'blog_id')) {
		rt.set_property(var_current_site, 'blog_id', rt.call_function('get_main_site_id', [
			rt.get_property(var_current_site, 'id'),
		]))
	}
	return true
}

fn ms_not_installed(var_domain rt.PhpVal, var_path rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_title := rt.new_null()
	mut var_msg := rt.new_null()
	mut var_query := rt.new_null()
	mut var_table := rt.new_null()
	mut var_t := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		rt.call_function('dead_db', []rt.PhpVal{})
	}
	rt.call_function('wp_load_translations_early', []rt.PhpVal{})
	var_title = rt.call_function('__', [
		rt.new_string('Error establishing a database connection'),
	])
	var_msg = rt.new_string('<h1>' + var_title.str() + '</h1>')
	var_msg = rt.concat(var_msg, rt.new_string('<p>' +
		(rt.call_function('__', [rt.new_string('If your site does not display, please contact the owner of this network.')])).str() +
		''))
	var_msg = rt.concat(var_msg, rt.new_string(' ' +
		(rt.call_function('__', [rt.new_string('If you are the owner of this network please check that your host&#8217;s database server is running properly and all tables are error free.')])).str() +
		'</p>'))
	var_query = rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('SHOW TABLES LIKE %s'),
		rt.call_method(var_wpdb, 'esc_like', [rt.get_property(var_wpdb, 'site')]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'get_var', [
		var_query.clone(),
	])))))
	{
		var_msg = rt.concat(var_msg, rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Database tables are missing.</strong> This means that your host&#8217;s database server is not running, WordPress was not installed properly, or someone deleted %s. You really should look at your database now.')]), rt.new_string('<code>' + (rt.get_property(var_wpdb, 'site')).str() +
			'</code>')])).str() + '</p>'))
	} else {
		var_msg = rt.concat(var_msg, rt.new_string('<p>' +
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('<strong>Could not find site %1$s.</strong> Searched for table %2$s in database %3$s. Is that right?')]), rt.new_string('<code>' + var_domain.str() +
			var_path.str().trim_right(' \t\n\r') + '</code>'), rt.new_string('<code>' +
			(rt.get_property(var_wpdb, 'blogs')).str() + '</code>'), rt.new_string('<code>' +
			(rt.get_constant('DB_NAME')).str() + '</code>')])).str() + '</p>'))
	}
	var_msg = rt.concat(var_msg, rt.new_string('<p><strong>' +
		(rt.call_function('__', [rt.new_string('What do I do now?')])).str() + '</strong> '))
	var_msg = rt.concat(var_msg, rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('Read the <a href="%s" target="_blank">Debugging a WordPress Network</a> article. Some of the suggestions there may help you figure out what went wrong.'),
		]),
		rt.call_function('__', [
			rt.new_string('https://developer.wordpress.org/advanced-administration/debug/debug-network/'),
		]),
	]))
	var_msg = rt.concat(var_msg, rt.new_string(' ' +
		(rt.call_function('__', [rt.new_string('If you are still stuck with this message, then check that your database contains the following tables:')])).str() +
		'</p><ul>'))
	mut iter_2 := rt.call_method(var_wpdb, 'tables', [rt.new_string('global')]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_table_shadow := item_2.val
		mut var_t_shadow := item_2.key
		if rt.is_true(rt.identical(rt.new_string('sitecategories'), var_t_shadow)) {
			continue
		}
		var_msg = rt.concat(var_msg, rt.new_string('<li>' + var_table_shadow.str() + '</li>'))
	}
	var_msg = rt.concat(var_msg, rt.new_string('</ul>'))
	rt.call_function('wp_die', [var_msg.clone(), var_title.clone(),
		rt.create_array([rt.ArrayItem{ key: 'response', val: 500 }])])
}

fn get_current_site_name(var_current_site rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.9.0'), rt.new_string('get_current_site()')])
	return var_current_site.clone()
}

fn wpmu_current_site() rt.PhpVal {
	mut var_current_site := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.9.0')])
	return var_current_site.clone()
}

fn wp_get_network(var_network_arg rt.PhpVal) bool {
	mut var_network := var_network_arg
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('4.7.0'), rt.new_string('get_network()')])
	var_network = rt.call_function('get_network', [var_network.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_network)) {
		return false
	}
	return var_network.to_bool()
}

struct Class_WP_Network {
	rt.PhpObjectBase
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_network(_args ...rt.PhpVal) &Class_WP_Network {
	mut obj := &Class_WP_Network{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_site(_args ...rt.PhpVal) &Class_WP_Site {
	mut obj := &Class_WP_Site{
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

fn (mut this Class_WP_Network) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Network) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Network) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
